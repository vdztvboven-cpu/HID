# HID Injection Cable (CH552P)

A USB HID injection device based on the CH552P microcontroller. It emulates a keyboard and types payloads written in DuckyScript-style syntax.

> **For authorized security testing and educational use only.** Only use this on systems you own or have explicit written permission to test.

## Contents

- `code/`: Arduino sketch (`.ino`) for the CH552P
- `converter.html`: converts DuckyScript to C++ for the Arduino IDE
- `sdcc.sh`: build helper script for SDCC
- `LICENSE`: MIT

## How it works

1. Write your payload in DuckyScript syntax.
2. Open `converter.html` in a browser and paste the script.
3. Copy the generated C++ output into the sketch in `code/`.
4. Flash the sketch to the CH552P board from the Arduino IDE.
5. Plug the device into the target machine. It appears as a standard USB keyboard and types the payload.

[Add a short description of the sketch here: how the payload is stored, what triggers execution, and whether there is a delay or LED indicator.]

## Requirements

- CH552P board
- Arduino IDE with the CH552 board package
- SDCC (for the build helper script)
- Zadig, for installing the driver on Windows

## Driver setup (Windows)

1. Connect the board while holding the boot button (if your board has one).
2. Open [Zadig](https://zadig.akeo.ie).
3. Select the CH552 device.
4. Choose the **libusb-win32** driver and click *Install*.
## Windows: driver note

Windows installs the WinUSB driver (via Zadig) for a specific USB port, not for the board itself. This means:

- A driver installed for one port does **not** apply to other ports.
- Using a USB dock can change the port a device appears on, so the driver may need to be reinstalled.
- Each board in bootloader mode shows the same ID (`4348:55E0`), so Zadig can't install the driver for all of them at once.

**Recommended workflow:** install WinUSB once on a fixed port, then flash one board at a time through that same port. Hold BOOT while plugging in each board, and unplug it after the flash reports OK.

## Troubleshooting

**Error related to `sdcc.sh`:** Replace the file in your installation with the version in this repository.

**Device not detected:** Check that the driver is installed with Zadig and that the board is not in a bad USB port.

## License

MIT. See [LICENSE](LICENSE).
