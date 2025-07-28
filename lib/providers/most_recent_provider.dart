import 'package:flutter/material.dart';
import 'package:islami_v2/core/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MostRecentProvider extends ChangeNotifier {
  List<int> mostRecentList = [];

  Future<void> loadMostRecent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mostRecentIndexesAsString =
        prefs.getStringList(SharedPrefsKeys.mostRecentKey) ?? [];

    mostRecentList =
        mostRecentIndexesAsString.map((e) => int.tryParse(e) ?? 0).toList();

    notifyListeners();
  }

  Future<void> addSura(int suraNum) async {
    mostRecentList.remove(suraNum); // لو متكررة، نحذفها الأول
    mostRecentList.insert(0, suraNum); // نضيفها أول القائمة

    if (mostRecentList.length > 10) {
      mostRecentList = mostRecentList.sublist(0, 10); // نخليهم 10 بس
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      SharedPrefsKeys.mostRecentKey,
      mostRecentList.map((e) => e.toString()).toList(),
    );

    notifyListeners();
  }
}
