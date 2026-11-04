#!/bin/sh
# wrapper around SDCC, POSIX sh version (runs under busybox ash on Windows)

VERBOSE=0
if [ "$1" = "-v" ]; then
	VERBOSE=1
	shift
elif [ "$1" = "-vv" ]; then
	VERBOSE=2
	set -x
	shift
fi

# On Windows, cp is not in PATH, so use the bundled tools in ../win
if ! command -v cp > /dev/null 2>&1; then
	cd "${0%/wrapper/*}" || exit 1
	PATH="$(pwd)/win:$PATH"
fi

if [ $VERBOSE -gt 0 ]; then
	printf '%s\n' "$*" >&2
fi

SDCC=$1
SRC=$2
OBJ=$3
REL=${OBJ%.o}.rel
MARK=$4
shift 4

if [ $VERBOSE -gt 0 ]; then
	printf 'Mark %s: %s %s %s -o %s\n' "$MARK" "$SDCC" "$*" "$SRC" "$OBJ" >&2
fi

# Preprocessor runs (library detection and prototype generation).
# Remove gcc-style flags that SDCC does not accept: -c, -MMD, and -MF <file>.
if [ "$MARK" = "re12" ]; then
	n=$#
	skip=0
	while [ $n -gt 0 ]; do
		arg=$1
		shift
		n=$((n - 1))
		if [ $skip -eq 1 ]; then
			skip=0
			continue
		fi
		case "$arg" in
			-c|-MMD) continue ;;
			-MF) skip=1; continue ;;
		esac
		set -- "$@" "$arg"
	done

	case "$SRC" in
		*.cpp.merged)
			"$SDCC" "$@" -x c "$SRC" -o "$OBJ"
			exit $? ;;
		*.cpp)
			"$SDCC" "$@" -x c --include dummy_variable_main.h "$SRC" -o "$OBJ"
			exit $? ;;
		*.c)
			"$SDCC" "$@" "$SRC" -o "$OBJ"
			exit $? ;;
	esac
	exit 1
fi

case "$SRC" in
	*.cpp.merged|*.cpp)
		# -x c compiles as C; dummy_variable_main.h pulls in main.c
		"$SDCC" "$@" -x c --include dummy_variable_main.h "$SRC" -o "$OBJ"
		ERR=$? ;;
	*.c)
		"$SDCC" "$@" "$SRC" -o "$OBJ"
		ERR=$? ;;
	*)
		ERR=1 ;;
esac

# Copy the generated .rel file to .o so the next build's dependency check passes
case "$OBJ" in
	*.o) cp -a "$OBJ" "$REL" ;;
esac

# Round a "A <NAME> size <HEX>" value up to an even number, in place
align_even() {
	name=$1
	str=$(grep -o "^A $name size [0-9A-Fa-f][0-9A-Fa-f]*" "$REL")
	if [ -z "$str" ]; then
		printf '%s String not found in %s\n' "$name" "$REL" >&2
		return
	fi
	hex=${str##* }
	dec=$(printf '%d' "0x$hex")
	if [ $VERBOSE -gt 0 ]; then
		printf '%s of %s is hex: %s, dec:%s\n' "$name" "$REL" "$hex" "$dec" >&2
	fi
	if [ $((dec % 2)) -eq 1 ]; then
		new=$(printf '%X' $((dec + 1)))
		if [ $VERBOSE -gt 0 ]; then
			printf 'Change %s value from %s to %s\n' "$name" "$hex" "$new" >&2
		fi
		sed -i -e "s/${str}/A ${name} size ${new}/g" "$REL"
	fi
}

if [ -f "$REL" ]; then
	align_even CSEG
	align_even GSINIT
	# The ljmp __sdcc_program_startup in main takes 4 bytes, not 3
	sed -i -e "s/A GSFINAL size 3/A GSFINAL size 4/g" "$REL"
fi

# propagate the sdcc exit code
exit $ERR