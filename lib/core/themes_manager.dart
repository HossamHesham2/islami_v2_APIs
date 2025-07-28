import 'package:flutter/material.dart';
import 'package:islami_v2/core/colors_manager.dart';

class ThemesManager {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.transParentColor,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.gold,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.transParentColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: ColorsManager.gold,
      )
    ),
  );
}
