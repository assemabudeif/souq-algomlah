import 'package:equatable/equatable.dart';
import '/core/constants/app_constance.dart';

import 'image_model.dart';

class ProductModel extends Equatable {
  final ImageModel firstImage;
  final ImageModel secondImage;
  final String id;
  final String name;
  final String arName;
  final String enName;
  final String desc;
  final double price;
  final bool isAvailable;
  final int amount;
  final double oldPrice;
  final String createdAt;
  final String updatedAt;
  final int v;
  final int purchaseLimit;

  const ProductModel({
    required this.firstImage,
    required this.secondImage,
    required this.id,
    required this.name,
    this.arName = '',
    this.enName = '',
    required this.desc,
    required this.price,
    required this.isAvailable,
    required this.amount,
    required this.oldPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.purchaseLimit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        firstImage: ImageModel.fromJson(json["firstImage"]),
        secondImage: ImageModel.fromJson(json["secondImage"]),
        id: json["_id"] ?? '',
        name: kAppLanguageCode == 'ar'
            ? json["name"] ?? ''
            : json["englishName"] ?? '',
        arName: json["name"] ?? '',
        enName: json["englishName"] ?? '',
        desc: kAppLanguageCode == 'ar'
            ? json["desc"] ?? ''
            : json["englishDesc"] ?? '',
        price: json["price"] is! String
            ? json["price"]?.toDouble()
            : double.parse(double.parse(json["price"]).toStringAsFixed(3)),
        isAvailable: json["isAvailable"],
        amount: json["amount"],
        oldPrice: json["oldPrice"] is! String
            ? json["oldPrice"]?.toDouble()
            : double.parse(double.parse(json["oldPrice"]).toStringAsFixed(3)),
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        v: json["__v"] ?? 0,
        purchaseLimit: json["purchaseLimit"] ?? -1,
      );

  @override
  List<Object?> get props => [
        firstImage,
        secondImage,
        id,
        name,
        desc,
        price,
        isAvailable,
        amount,
        oldPrice,
        createdAt,
        updatedAt,
        v,
        purchaseLimit,
      ];
}
