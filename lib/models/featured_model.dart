class FeaturedModel {
  final String photoUrl, date;

  FeaturedModel({this.date, this.photoUrl});

  Map<String, dynamic> toJSON() {
    return {'photoUrl': photoUrl, 'date': date};
  }

  factory FeaturedModel.fromJSON(Map<String, dynamic> json) {
    return FeaturedModel(date: json['date'], photoUrl: json['photoUrl']);
  }
}
