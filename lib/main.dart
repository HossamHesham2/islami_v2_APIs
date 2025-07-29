import 'package:flutter/material.dart';
import 'package:islami_v2/core/routes_manager.dart';
import 'package:islami_v2/my_app.dart';
import 'package:islami_v2/providers/most_recent_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

  void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('isOnBoardingSeen') ?? false;


  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final provider = MostRecentProvider();
        provider.loadMostRecent(); 
        return provider;
      },
      child: MyApp(initialRoute: seen ? RoutesManager.homeScreen : RoutesManager.onBoardingScreen),
    ),
  );
}
