import 'package:equatable/equatable.dart';
import '/core/constants/app_constance.dart';

import 'product_model.dart';

class SubCategoryModel extends Equatable {
  final String id;
  final String name;
  final List<ProductModel> products;
  final int v;

  const SubCategoryModel({
    required this.id,
    required this.name,
    required this.products,
    required this.v,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["_id"] ?? '',
        name: kAppLanguageCode == 'ar'
            ? json["name"] ?? ''
            : json["englishName"] ?? '',
        products: json["products"] != null
            ? List<ProductModel>.from(
                    json["products"].map((x) => ProductModel.fromJson(x)))
                .where((element) => element.isAvailable)
                .toList()
            : [],
        v: json["__v"] ?? 0,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        products,
        v,
      ];
}
