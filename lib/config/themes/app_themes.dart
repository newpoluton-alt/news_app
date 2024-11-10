import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white, appBarTheme: appBarTheme());
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xff8b8b8b)),
      titleTextStyle: TextStyle(color: Color(0xff8b8b8b), fontSize: 18),
      elevation: 0);
}
