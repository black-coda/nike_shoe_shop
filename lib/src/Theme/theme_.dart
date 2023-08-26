import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xffF7F7F9),
  fontFamily: "RaleWay",
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Color(0xffECECEC),
      fontWeight: FontWeight.w900,
      fontSize: 30,
      fontFamily: 'RaleWay',
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
  ),
  useMaterial3: true,
);
