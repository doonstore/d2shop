class ApartmentModel {
  final String value;

  const ApartmentModel({this.value});

  factory ApartmentModel.fromJson(Map json) =>
      ApartmentModel(value: json['value']);

  toJson() => {'value': value};
}
