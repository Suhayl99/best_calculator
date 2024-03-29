import 'package:flutter/material.dart';

Color nightBgClr = const Color(0xFF17171C);
Color lightBgClr = const Color(0xFFF1F2F3);
Color actionsRowColor = const Color(0xFFD2D3DA);
Color actionsLightRowClr = const Color(0xFFD2D3DA);
Color nightactionsClmnClr = const Color(0xFF4E505F);
Color numbersClr = const Color(0xFF2E2F38);
Color black = Colors.black;
Color white = Colors.white;


TextStyle kTextStyle({
  Color? color,
  double size = 14,
  FontWeight fontWeight = FontWeight.w500,
  double? letterSpacing,
  double? height,
}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height);
}

const String calculateBox='calculate_box';
const String currencyBox = 'currency_box';
const String settingBox= 'setting_box';
const String currencyListKey = 'currency_list_key';
const String dateBox = 'date_box';
const String accuracyKeyBox='accuracy_key';
const String dateKey = 'date_key';
const String textKeyBox='text_key';
const String barKeyBox='bar_key';
const String screenKeyBox='screen_key';
const String swipeKeyBox='swipe_key';
const String vibrationKeyBox='vibration_key';