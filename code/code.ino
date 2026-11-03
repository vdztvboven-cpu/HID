// DuckyScript Sketch for CH552 (ch55xduino)
// Target layout: US QWERTY
// Tools -> USB Settings -> USER CODE w/ 148B USB ram
#ifndef USER_USB_RAM
#error "Select Tools -> USB Settings -> USER CODE w/ 148B USB ram"
#endif
#include "src/userUsbHidKeyboard/USBHIDKeyboard.h"

void payload() {
  // Rickroll Payload
  // default delay: 20 ms
  delay(1000);
  delay(20);
  Keyboard_press(KEY_LEFT_GUI);
  Keyboard_press('r');
  delay(30);
  Keyboard_releaseAll();
  delay(15);
  delay(20);
  delay(500);
  delay(20);
  Keyboard_write('h');
  delay(5);
  Keyboard_write('t');
  delay(5);
  Keyboard_write('t');
  delay(5);
  Keyboard_write('p');
  delay(5);
  Keyboard_write('s');
  delay(5);
  Keyboard_write(':');
  delay(5);
  Keyboard_write('/');
  delay(5);
  Keyboard_write('/');
  delay(5);
  Keyboard_write('w');
  delay(5);
  Keyboard_write('w');
  delay(5);
  Keyboard_write('w');
  delay(5);
  Keyboard_write('.');
  delay(5);
  Keyboard_write('y');
  delay(5);
  Keyboard_write('o');
  delay(5);
  Keyboard_write('u');
  delay(5);
  Keyboard_write('t');
  delay(5);
  Keyboard_write('u');
  delay(5);
  Keyboard_write('b');
  delay(5);
  Keyboard_write('e');
  delay(5);
  Keyboard_write('.');
  delay(5);
  Keyboard_write('c');
  delay(5);
  Keyboard_write('o');
  delay(5);
  Keyboard_write('m');
  delay(5);
  Keyboard_write('/');
  delay(5);
  Keyboard_write('w');
  delay(5);
  Keyboard_write('a');
  delay(5);
  Keyboard_write('t');
  delay(5);
  Keyboard_write('c');
  delay(5);
  Keyboard_write('h');
  delay(5);
  Keyboard_write('?');
  delay(5);
  Keyboard_write('v');
  delay(5);
  Keyboard_write('=');
  delay(5);
  Keyboard_write('d');
  delay(5);
  Keyboard_write('Q');
  delay(5);
  Keyboard_write('w');
  delay(5);
  Keyboard_write('4');
  delay(5);
  Keyboard_write('w');
  delay(5);
  Keyboard_write('9');
  delay(5);
  Keyboard_write('W');
  delay(5);
  Keyboard_write('g');
  delay(5);
  Keyboard_write('X');
  delay(5);
  Keyboard_write('c');
  delay(5);
  Keyboard_write('Q');
  delay(5);
  delay(20);
  Keyboard_press(KEY_RETURN);
  delay(30);
  Keyboard_releaseAll();
  delay(15);
  delay(20);
}

void setup() {
  USBInit();
  delay(3000); // Wacht op USB enumeratie
  payload();
}

void loop() {}
