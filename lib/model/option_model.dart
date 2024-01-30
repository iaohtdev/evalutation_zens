class OptionModel {
  final int id;
  final String name;
  final double price;

  OptionModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
        id: json['id'], name: json['name'], price: json['price']);
  }
}
