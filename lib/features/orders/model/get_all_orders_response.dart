import 'post_order_request.dart';

class GetAllOrdersResponse {
  Address? address;
  int? paiedFromWallet;
  String? id;
  String? user;
  String? phone;
  String? state;
  double? productsPrice;
  double? totalCost;
  double? shippingCost;
  List<Cart>? cart;
  bool? onlinePay;
  bool? isPaidOnline;
  int? v;
  String? encryptedParams;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetAllOrdersResponse({
    this.address,
    this.paiedFromWallet,
    this.id,
    this.user,
    this.phone,
    this.state,
    this.productsPrice,
    this.totalCost,
    this.shippingCost,
    this.cart,
    this.onlinePay,
    this.isPaidOnline,
    this.v,
    this.encryptedParams,
    this.createdAt,
    this.updatedAt,
  });

  GetAllOrdersResponse.fromJson(Map<String, dynamic> json) {
    address =
        json["address"] == null ? null : Address.fromJson(json["address"]);
    paiedFromWallet = (json["paiedFromWallet"] as num).toInt();
    id = json["_id"];
    user = json["user"];
    phone = json["phone"];
    state = json["state"];
    productsPrice = (json["productsPrice"] as num).toDouble();
    totalCost = (json["totalCost"] as num).toDouble();
    shippingCost = (json["shippingCost"] as num).toDouble();
    cart = json["cart"] == null
        ? null
        : (json["cart"] as List).map((e) => Cart.fromJson(e)).toList();
    onlinePay = json["onlinePay"];
    isPaidOnline = json["isPaidOnline"];
    v = (json["__v"] as num).toInt();
    encryptedParams = json["encryptedParams"];
    createdAt =
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]);
    updatedAt =
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]);
  }
}

class Cart {
  Product? product;
  int? amount;
  String? id;

  Cart({this.product, this.amount, this.id});

  Cart.fromJson(Map<String, dynamic> json) {
    product =
        json["product"] == null ? null : Product.fromJson(json["product"]);
    amount = (json["amount"] as num).toInt();
    id = json["_id"];
  }
}

class Product {
  FirstImage? firstImage;
  SecondImage? secondImage;
  String? id;
  String? name;
  String? englishName;
  String? desc;
  String? englishDesc;
  double? price;
  bool? isAvailable;
  int? amount;
  double? oldPrice;
  String? createdAt;
  String? updatedAt;
  int? v;

  Product(
      {this.firstImage,
      this.secondImage,
      this.id,
      this.name,
      this.englishName,
      this.desc,
      this.englishDesc,
      this.price,
      this.isAvailable,
      this.amount,
      this.oldPrice,
      this.createdAt,
      this.updatedAt,
      this.v});

  Product.fromJson(Map<String, dynamic> json) {
    firstImage = json["firstImage"] == null
        ? null
        : FirstImage.fromJson(json["firstImage"]);
    secondImage = json["secondImage"] == null
        ? null
        : SecondImage.fromJson(json["secondImage"]);
    id = json["_id"];
    name = json["name"];
    englishName = json["englishName"];
    desc = json["desc"];
    englishDesc = json["englishDesc"];
    price = (json["price"] as num).toDouble();
    isAvailable = json["isAvailable"];
    amount = (json["amount"] as num).toInt();
    oldPrice = (json["oldPrice"] as num).toDouble();
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = (json["__v"] as num).toInt();
  }
}

class SecondImage {
  String? url;
  String? publicId;

  SecondImage({this.url, this.publicId});

  SecondImage.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    publicId = json["public_id"];
  }
}

class FirstImage {
  String? url;
  String? publicId;

  FirstImage({this.url, this.publicId});

  FirstImage.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    publicId = json["public_id"];
  }
}
