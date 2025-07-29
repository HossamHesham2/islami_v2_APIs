import 'package:islami_v2/models/moshaf_model.dart';

class ReciterModel {
  final int id;
  final String name;
  final String letter;
  final String date;
  final List<MoshafModel> moshaf;

  ReciterModel({
    required this.id,
    required this.name,
    required this.letter,
    required this.date,
    required this.moshaf,
  });

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    return ReciterModel(
      id: json['id'],
      name: json['name'],
      letter: json['letter'],
      date: json['date'],
      moshaf: (json['moshaf'] as List)
          .map((e) => MoshafModel.fromJson(e))
          .toList(),
    );
  }
}
