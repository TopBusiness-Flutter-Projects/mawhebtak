import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  static Color primary = const Color(0xff3761EA);
  static Color secondPrimary = HexColor('#48B6F0');
  static Color grayLite = const Color(0xffF7F7F7);
  static Color grayLite2 =  HexColor("#F7F7F7");
  static Color whiteSecond =  HexColor('#8C7B95');
  static Color darkGray = const Color(0xff464545);
  static Color gray = const Color(0xffC0C0C0);
  static Color grayMedium = HexColor('#ADADAD');
  static Color grayAfaf = HexColor('#AFAFAF');

  static Color red = HexColor('#FF0000');
  static Color redLight = HexColor('#C598C2');
  static Color green = HexColor('#48D6A4');
  static Color black = Colors.black;
  static Color blackLite = HexColor('#2B2430');
  static Color homeColor = HexColor('#151F41');
  static Color blueMeduim = HexColor('#311F3A');
  static Color blueLight = HexColor('#3AABF3');
  static Color blueveryLight = HexColor('#E1E6F3');
  static Color success = Colors.green;
  static Color lbny = HexColor('#2ECAEF');
  static Color white = HexColor('#FFFFFF');
  static Color error = Colors.red;
  static Color transparent = Colors.transparent;
  static Color backgroundColor = HexColor('#F9F9F9');

  static Color grayDark = HexColor('#464545');
  static Color grayLight = HexColor('#BFBFBF');
  static Color grayDate = HexColor('#BABABA');
  static Color grayText = HexColor('#C3C3C3');
  static Color grayText2 = HexColor('#C8C8C8');
  static Color grayText3 = HexColor('#928F8F');
  static Color grayDarkkk = HexColor('#B4B4B4');

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
