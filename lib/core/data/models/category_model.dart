import 'package:equatable/equatable.dart';
import '/core/constants/app_constance.dart';

import 'image_model.dart';
import 'sub_category_model.dart';

class CategoryModel extends Equatable {
  final ImageModel img;
  final ImageModel firstBanner;
  final ImageModel secondBanner;
  final String id;
  final String name;
  final List<SubCategoryModel> subCategories;
  final int v;

  const CategoryModel({
    required this.img,
    required this.firstBanner,
    required this.secondBanner,
    required this.id,
    required this.name,
    required this.subCategories,
    required this.v,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        img: ImageModel.fromJson(json["img"]),
        firstBanner: ImageModel.fromJson(json["firstBanner"]),
        secondBanner: ImageModel.fromJson(json["secondBanner"]),
        id: json["_id"] ?? '',
        name: kAppLanguageCode == 'ar'
            ? json["name"] ?? ''
            : json["englishName"] ?? '',
        subCategories: json["subCategories"] != null
            ? List<SubCategoryModel>.from(
                json["subCategories"].map((x) => SubCategoryModel.fromJson(x)))
            : [],
        v: json["__v"] ?? 0,
      );

  @override
  List<Object?> get props => [
        img,
        firstBanner,
        secondBanner,
        id,
        name,
        subCategories,
        v,
      ];
}
