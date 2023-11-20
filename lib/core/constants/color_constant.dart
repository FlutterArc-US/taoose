import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color indigo9007f = fromHex('#7f131163');
  static Color taous1 = fromHex('#02FFFF');
  static Color taous2 = fromHex('#B025A7');

  static Color teal40067 = fromHex('#6736a693');

  static Color bluegray51 = fromHex('#eff2f5');

  static Color bluegray50 = fromHex('#ecf1f0');

  static Color black900B2 = fromHex('#b2000000');

  static Color cyan9008e = fromHex('#8e023c69');

  static Color blueA200 = fromHex('#4485fd');

  static Color black90087 = fromHex('#87000000');

  static Color greenA700 = fromHex('#00cc6a');

  static Color gray50066 = fromHex('#66a9a9a9');

  static Color redA701 = fromHex('#be0000');

  static Color redA700 = fromHex('#ff0202');

  static Color pink100 = fromHex('#f9afb4');

  static Color gray202 = fromHex('#f2eaea');

  static Color blue700 = fromHex('#137ecd');

  static Color black9000f = fromHex('#0f000000');

  static Color gray200 = fromHex('#e8e6ea');

  static Color black9000c = fromHex('#0c000000');

  static Color gray201 = fromHex('#e9e9e9');

  static Color teal4000a = fromHex('#0a36a693');

  static Color bluegray801 = fromHex('#243b4d');

  static Color cyan200 = fromHex('#77e9de');

  static Color bluegray800 = fromHex('#42405a');

  static Color bluegray401 = fromHex('#888888');

  static Color bluegray400 = fromHex('#868686');

  static Color bluegray200 = fromHex('#adafbb');

  static Color cyan50 = fromHex('#d7fff8');

  static Color bluegray1007f = fromHex('#7fcacccf');

  static Color black90014 = fromHex('#14000000');

  static Color whiteA701 = fromHex('#fefefe');

  static Color whiteA700 = fromHex('#ffffff');

  static Color teal507f = fromHex('#7fe1ecf2');

  static Color gray5003f = fromHex('#3f9d9d9d');

  static Color teal200 = fromHex('#fbfbfb');

  static Color gray300Cc = fromHex('#ccd9dcde');

  static Color teal400 = fromHex('#36a693');

  static Color teal201 = fromHex('#61d0bd');

  static Color teal4007e = fromHex('#7e36a693');

  static Color black90066 = fromHex('#66000000');

  static Color black900 = fromHex('#050225');

  static Color black90063 = fromHex('#63000000');

  static Color black902 = fromHex('#000000');

  static Color black901 = fromHex('#000000');

  static Color deepPurpleA100 = fromHex('#bda8fb');

  static Color bluegray9007f = fromHex('#7f0d2a3e');

  static Color black90026 = fromHex('#26000000');

  static Color teal40033 = fromHex('#3336a693');

  static Color gray502 = fromHex('#a9abae');

  static Color gray301 = fromHex('#dadada');

  static Color gray500 = fromHex('#aaacae');

  static Color gray505 = fromHex('#9e9e9e');

  static Color gray506 = fromHex('#aaaaaa');

  static Color gray900 = fromHex('#001a30');

  static Color blue600 = fromHex('#2b92e4');

  static Color bluegray100 = fromHex('#d9d9d9');

  static Color gray101 = fromHex('#f3f3f3');

  static Color gray300 = fromHex('#e3e3e3');

  static Color tealA200 = fromHex('#7bfad2');

  static Color gray100 = fromHex('#f3f3fa');

  static Color bluegray900 = fromHex('#0d2a3e');

  static Color gray3007f = fromHex('#7fd9dcde');

  static Color bluegray700 = fromHex('#516562');

  static Color black900Cc = fromHex('#cc000000');

  static Color indigo30028 = fromHex('#287a80be');

  static Color indigo900 = fromHex('#131163');

  static Color blue200 = fromHex('#a4bff7');

  static Color bluegray901 = fromHex('#1c2443');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
