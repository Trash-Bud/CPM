
import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData appTheme = ThemeData(

  primaryColor: ColorPallet.darkPink,
  scaffoldBackgroundColor: Colors.white,

  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(ColorPallet.darkPink),
        textStyle: MaterialStateTextStyle.resolveWith(
                (states) => const TextStyle(decoration: TextDecoration.underline)),
      )
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      backgroundColor:
      MaterialStateProperty.all<Color>(ColorPallet.darkPink),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateTextStyle.resolveWith(
              (states) => const TextStyle(fontSize: 20)),
    ),
  ),

);