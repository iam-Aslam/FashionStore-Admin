import 'package:flutter/material.dart';

const khieght5 = SizedBox(height: 5);
const khieght10 = SizedBox(height: 10);
const khieght20 = SizedBox(height: 20);
const khieght30 = SizedBox(height: 30);
const khieght40 = SizedBox(height: 40);
const khieght50 = SizedBox(height: 50);
const khieght60 = SizedBox(height: 60);

//colors
const kTextBlackColor = Colors.black;
const Color kMainBgColor = Colors.white;
const Color kAppBarIconColor = Colors.grey;
Color kHomeSearchIconColor = Colors.grey.shade600;
const Color bottomNavBarSelectedColor = Colors.black;
const Color bottomNavBarUnselectedColor = Colors.grey;

//material color for black
const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
