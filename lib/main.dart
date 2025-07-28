import 'package:flutter/material.dart';
import 'package:islami_v2/my_app.dart';
import 'package:islami_v2/providers/most_recent_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // void main() async{
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool seen = prefs.getBool('isOnBoardingSeen') ?? false;

  // runApp( MyApp(initialRoute: seen ? RoutesManager.homeScreen : RoutesManager.onBoardingScreen,));

  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final provider = MostRecentProvider();
        provider.loadMostRecent(); 
        return provider;
      },
      child: MyApp(),
    ),
  );
}
