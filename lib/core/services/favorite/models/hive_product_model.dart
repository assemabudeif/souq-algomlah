import 'package:hive/hive.dart';

part 'hive_product_model.g.dart';

@HiveType(typeId: 2)
class HiveProductModel extends HiveObject {
  @HiveField(0)
  final String firstImage;
  @HiveField(1)
  final String secondImage;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String desc;
  @HiveField(5)
  final double price;
  @HiveField(6)
  final bool isAvailable;
  @HiveField(7)
  final int amount;
  @HiveField(8)
  final double oldPrice;
  @HiveField(9)
  final String createdAt;
  @HiveField(10)
  final String updatedAt;
  @HiveField(11)
  final int v;
  @HiveField(12)
  final String englishName;
  @HiveField(13)
  final int purchaseLimit;

  // @HiveField(13)
  // final String? categoryId;

  HiveProductModel({
    required this.firstImage,
    required this.secondImage,
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.isAvailable,
    required this.amount,
    required this.oldPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.englishName,
    required this.purchaseLimit,
  });

  factory HiveProductModel.fromJson(Map<String, dynamic> json) {
    return HiveProductModel(
      firstImage: json['firstImage'] ?? '',
      secondImage: json['secondImage'] ?? '',
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      isAvailable: json['isAvailable'] ?? false,
      amount: json['amount'] ?? 0,
      oldPrice: json['oldPrice']?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      englishName: json['englishName'] ?? '',
      purchaseLimit: json['purchaseLimit'] ?? -1,
      // categoryId: json['categoryId'] ?? '',
    );
  }
}
