class RadioModel {
  int id;
  String name;
  String url;
  String recent_date;

  RadioModel({
    required this.id,
    required this.name,
    required this.url,
    required this.recent_date,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json){
    return RadioModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        recent_date: json["recent_date"],
    );
  }
}
