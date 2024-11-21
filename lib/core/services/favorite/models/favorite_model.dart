import 'package:hive/hive.dart';
import 'hive_product_model.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final HiveProductModel product;

  FavoriteModel({required this.id, required this.product});
}
