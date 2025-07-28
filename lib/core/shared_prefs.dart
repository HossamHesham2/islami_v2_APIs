import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKeys {
  static const String mostRecentKey = "most_recent";
}

void saveLastSuraIndex(int newSuraIndex) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //todo: get sura list from shared prefs
  List<String> mostRececntIdexsesList =
      prefs.getStringList(SharedPrefsKeys.mostRecentKey) ?? [];
  //todo: add sura list in mostRececntIdexsesList

  if (mostRececntIdexsesList.contains('$newSuraIndex')) {
    mostRececntIdexsesList.remove('$newSuraIndex');
    mostRececntIdexsesList.insert(0, '$newSuraIndex');
  } else {
    mostRececntIdexsesList.insert(0, '$newSuraIndex');
  }
  if (mostRececntIdexsesList.length > 5) {
    mostRececntIdexsesList = mostRececntIdexsesList.sublist(0, 5);
  }
  //todo: Save new sura index in shared prefs
  await prefs.setStringList(
    SharedPrefsKeys.mostRecentKey,
    mostRececntIdexsesList,
  );
}

Future<List<int>> readLastSuraList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> mostRecentIndexesAsString =
      prefs.getStringList(SharedPrefsKeys.mostRecentKey) ?? [];
  //todo: List<String> => List<int> -> map()
  List<int> mostRecentIndexesAsInt = mostRecentIndexesAsString
      .map((e) => int.parse(e))
      .toList();
  return mostRecentIndexesAsInt;
}
