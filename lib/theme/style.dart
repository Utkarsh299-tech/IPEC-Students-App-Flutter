import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData appTheme = new ThemeData(
  hintColor: Colors.white,
  brightness: Brightness.light,
  fontFamily: 'Averta',
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    headline1: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    headline4: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    headline6: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   // fillColor: kLighterGrey,
  //   // filled: true,
  //   border: OutlineInputBorder(
  //     borderSide: BorderSide.none,
  //     borderRadius: BorderRadius.circular(kLowCircleRadius),
  //   ),
  // ),
);
ThemeData appdarkTheme = new ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Averta',
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kDarkBg,
  textTheme: TextTheme(
    headline1: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
    headline4: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    headline6: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   // fillColor: kLighterGrey,
  //   // filled: true,
  //   border: OutlineInputBorder(
  //     borderSide: BorderSide.none,
  //     borderRadius: BorderRadius.circular(kLowCircleRadius),
  //   ),
  // ),
);

const kLowCircleRadius = 20.0;
const kMedCircleRadius = 30.0;

// Text
const kHeadingSize = 4.0;
const kBodySize = 3.0;
const kParagraphSize = 2.0;

//Padding
const kLowPadding = SizedBox(
  height: 10,
);
const kMedPadding = SizedBox(
  height: 20,
);
const kHighPadding = SizedBox(
  height: 30,
);

const kLowWidthPadding = SizedBox(
  width: 10,
);
const kMedWidthPadding = SizedBox(
  width: 20,
);
const kHighWidthPadding = SizedBox(
  width: 30,
);

const kBoldH3 = TextStyle(fontWeight: FontWeight.bold);
