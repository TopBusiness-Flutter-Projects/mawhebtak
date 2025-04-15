import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  static Color primary = const Color(0xff3761EA);
  static Color secondPrimary = HexColor('#48B6F0');
  static Color grayLite = const Color(0xffF7F7F7);
  static Color darkGray = const Color(0xff464545);
  static Color gray = const Color(0xffC0C0C0);

  static Color red = HexColor('#FF0000');
  static Color redLight = HexColor('#C598C2');
  static Color black = Colors.black;
  static Color blackLite = HexColor('#2B2430');
  static Color homeColor = HexColor('#151F41');
  static Color blueMeduim = HexColor('#311F3A');
  static Color success = Colors.green;
  static Color lbny = HexColor('#2ECAEF');
  static Color white = Colors.white;
  static Color error = Colors.red;
  static Color transparent = Colors.transparent;

  static Color grayDark = HexColor('#464545');
  static Color grayLight = HexColor('#BFBFBF');
  static Color grayText = HexColor('#C3C3C3');

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lightens(String color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(HexColor(color));
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
