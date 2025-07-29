class MoshafModel {
  final int id;
  final String name;
  final String server;
  final int surahTotal;
  final int moshafType;
  final List<int> surahList;

  MoshafModel({
    required this.id,
    required this.name,
    required this.server,
    required this.surahTotal,
    required this.moshafType,
    required this.surahList,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json) {
    return MoshafModel(
      id: json['id'],
      name: json['name'],
      server: json['server'],
      surahTotal: json['surah_total'],
      moshafType: json['moshaf_type'],
      surahList: (json['surah_list'] as String)
          .split(',')
          .map((e) => int.parse(e))
          .toList(),
    );
  }
}
