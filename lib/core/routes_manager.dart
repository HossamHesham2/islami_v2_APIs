import 'package:flutter/cupertino.dart';
import 'package:islami_v2/home_screen.dart';
import 'package:islami_v2/on_boarding_screen/on_boarding_screen.dart';
import 'package:islami_v2/tabs/quran_tab/details1/sura_details_screen1.dart';

class RoutesManager {
  static const String homeScreen = "/homeScreen";
  static const String suraDetails = "/suraDetails";
  static const String onBoardingScreen = "/onBoardingScreen";

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
    case suraDetails:
        return CupertinoPageRoute(builder: (context) => SuraDetailsScreen1(),settings: settings);
    case onBoardingScreen:
        return CupertinoPageRoute(builder: (context) => OnBoardingScreen(),settings: settings);
    }
    return null;
  }
}
