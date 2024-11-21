class ProductModel {
  final Product product;
  final List<Product> relatedProducts;

  ProductModel({
    required this.product,
    required this.relatedProducts,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        product: Product.fromJson(json["product"]),
        relatedProducts: json["relatedProducts"] != null
            ? List<Product>.from(
                json["relatedProducts"].map((x) => Product.fromJson(x)))
            : [],
      );
}

class Product {
  final ImageModel firstImage;
  final ImageModel secondImage;
  final String id;
  final String name;
  final String englishName;
  final String desc;
  final String englishDesc;
  final double price;
  final bool isAvailable;
  final int amount;
  final int purchaseLimit;
  final double oldPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Product({
    required this.firstImage,
    required this.secondImage,
    required this.id,
    required this.name,
    required this.englishName,
    required this.desc,
    required this.englishDesc,
    required this.price,
    required this.isAvailable,
    required this.amount,
    required this.purchaseLimit,
    required this.oldPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        firstImage: ImageModel.fromJson(json["firstImage"]),
        secondImage: ImageModel.fromJson(json["secondImage"]),
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        englishName: json["englishName"] ?? "",
        desc: json["desc"] ?? "",
        englishDesc: json["englishDesc"] ?? "",
        price: json["price"]?.toDouble() ?? 0.0,
        isAvailable: json["isAvailable"] ?? false,
        amount: json["amount"] ?? 0,
        purchaseLimit: json["purchaseLimit"] ?? -1,
        oldPrice: json["oldPrice"]?.toDouble() ?? 0.0,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );
}

class ImageModel {
  final String publicId;
  final String url;

  ImageModel({
    required this.publicId,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        publicId: json["public_id"] ?? "",
        url: json["url"] ?? "",
      );
}
