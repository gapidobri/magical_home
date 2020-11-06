import 'dart:ui';

import 'package:magic_home/magic_home.dart' as led;

Color toUIColor(led.Color ledColor) {
  return Color.fromRGBO(ledColor.r, ledColor.g, ledColor.b, 1.0);
}

led.Color fromUIColor(Color color) {
  return led.Color(color.red, color.green, color.blue);
}