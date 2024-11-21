import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String id;
  final String name;
  final String englishName;
  final double shippingCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  const CityModel({
    required this.id,
    required this.name,
    required this.englishName,
    required this.shippingCost,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        englishName: json["englishName"] ?? '',
        shippingCost: json["shippingCost"]?.toDouble() ?? 0.0,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );

  @override
  List<Object> get props => [
        id,
        name,
        englishName,
        shippingCost,
        createdAt,
        updatedAt,
        v,
      ];
}
