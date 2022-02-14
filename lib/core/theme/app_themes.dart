import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static ThemeData get defaultTheme => ThemeData(
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
          headline4: TextStyle(fontSize: 20.sp),
          subtitle2: TextStyle(fontSize: 14.sp),
          subtitle1: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)));
}
