import 'package:equatable/equatable.dart';
import 'category_model.dart';

class AllCategoriesModel extends Equatable {
  final List<CategoryModel> allCategories;

  const AllCategoriesModel({required this.allCategories});

  factory AllCategoriesModel.fromJson(json) {
    return AllCategoriesModel(
      allCategories: json != null
          ? List<CategoryModel>.from(json.map((x) => CategoryModel.fromJson(x)))
          : [],
    );
  }

  @override
  List<Object?> get props => [allCategories];
}
