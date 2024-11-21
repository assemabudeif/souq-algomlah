import 'package:hive/hive.dart';
import '/core/services/favorite/models/hive_product_model.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final HiveProductModel product;
  @HiveField(2)
  int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    this.quantity = 1,
  });
}
