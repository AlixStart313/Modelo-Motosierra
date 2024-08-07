class Motosierra {
  final int id;
  final String brand;
  final String model;
  final String power;
  final String weigth;

  Motosierra({
    required this.id,
    required this.brand,
    required this.model,
    required this.power,
    required this.weigth,
  });

  factory Motosierra.fromJson(Map<String, dynamic> json) {
    return Motosierra(
      id: json['id'] as int,
      brand: json['brand'] as String,
      model: json['model'] as String,
      power: json['power'] as String,
      weigth: json['weigth'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': power,
      'color': weigth,
    };
  }
}
