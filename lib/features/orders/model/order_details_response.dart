import '/core/data/models/product_model.dart';

class OrderDetailsResponse {
  AddressForOrderDetails? address;
  String? id;
  UserForOrderDetails? user;
  String? phone;
  String? state;
  double? productsPrice;
  double? totalCost;
  double? shippingCost;
  List<CartForOrderDetails>? cart;
  bool? onlinePay;
  bool? isPaidOnline;
  int? paiedFromWallet;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? encryptedParams;

  OrderDetailsResponse(
      {this.address,
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
      this.paiedFromWallet,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.encryptedParams});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    address = json["address"] == null
        ? null
        : AddressForOrderDetails.fromJson(json["address"]);
    id = json["_id"];
    user = json["user"] == null
        ? null
        : UserForOrderDetails.fromJson(json["user"]);
    phone = json["phone"];
    state = json["state"];
    productsPrice = (json["productsPrice"] as num).toDouble();
    totalCost = (json["totalCost"] as num).toDouble();
    shippingCost = (json["shippingCost"] as num).toDouble();
    cart = json["cart"] == null
        ? null
        : (json["cart"] as List)
            .map((e) => CartForOrderDetails.fromJson(e))
            .toList();
    onlinePay = json["onlinePay"];
    isPaidOnline = json["isPaidOnline"];
    paiedFromWallet = (json["paiedFromWallet"] as num).toInt();
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = (json["__v"] as num).toInt();
    encryptedParams = json["encryptedParams"];
  }
}

class CartForOrderDetails {
  ProductModel? product;
  int? amount;
  double? price;
  String? id;

  CartForOrderDetails({this.product, this.amount, this.price, this.id});

  CartForOrderDetails.fromJson(Map<String, dynamic> json) {
    product =
        json["product"] == null ? null : ProductModel.fromJson(json["product"]);
    amount = (json["amount"] as num).toInt();
    price = (json["price"] as num).toDouble();
    id = json["_id"];
  }
}

// class ProductForOrderDetails {
//   FirstImageForOrderDetails? firstImage;
//   SecondImageForOrderDetails? secondImage;
//   String? id;
//   String? name;
//   String? englishName;
//   String? desc;
//   String? englishDesc;
//   double? price;
//   bool? isAvailable;
//   int? amount;
//   double? oldPrice;
//   String? createdAt;
//   String? updatedAt;
//   int? v;

//   ProductForOrderDetails(
//       {this.firstImage,
//       this.secondImage,
//       this.id,
//       this.name,
//       this.englishName,
//       this.desc,
//       this.englishDesc,
//       this.price,
//       this.isAvailable,
//       this.amount,
//       this.oldPrice,
//       this.createdAt,
//       this.updatedAt,
//       this.v});

//   ProductForOrderDetails.fromJson(Map<String, dynamic> json) {
//     firstImage = json["firstImage"] == null
//         ? null
//         : FirstImageForOrderDetails.fromJson(json["firstImage"]);
//     secondImage = json["secondImage"] == null
//         ? null
//         : SecondImageForOrderDetails.fromJson(json["secondImage"]);
//     id = json["_id"];
//     name = json["name"];
//     englishName = json["englishName"];
//     desc = json["desc"];
//     englishDesc = json["englishDesc"];
//     price = (json["price"] as num).toDouble();
//     isAvailable = json["isAvailable"];
//     amount = (json["amount"] as num).toInt();
//     oldPrice = (json["oldPrice"] as num).toDouble();
//     createdAt = json["createdAt"];
//     updatedAt = json["updatedAt"];
//     v = (json["__v"] as num).toInt();
//   }
// }

class SecondImageForOrderDetails {
  String? url;
  String? publicId;

  SecondImageForOrderDetails({this.url, this.publicId});

  SecondImageForOrderDetails.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    publicId = json["public_id"];
  }
}

class FirstImageForOrderDetails {
  String? url;
  String? publicId;

  FirstImageForOrderDetails({this.url, this.publicId});

  FirstImageForOrderDetails.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    publicId = json["public_id"];
  }
}

class UserForOrderDetails {
  Address1ForOrderDetails? address;
  String? id;
  String? name;
  String? password;
  String? phone;
  String? secoundPhone;
  String? email;
  bool? isAdmin;
  int? points;
  double? wallet;
  String? otp;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  int? v;

  UserForOrderDetails(
      {this.address,
      this.id,
      this.name,
      this.password,
      this.phone,
      this.secoundPhone,
      this.email,
      this.isAdmin,
      this.points,
      this.wallet,
      this.otp,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.v});

  UserForOrderDetails.fromJson(Map<String, dynamic> json) {
    address = json["address"] == null
        ? null
        : Address1ForOrderDetails.fromJson(json["address"]);
    id = json["_id"];
    name = json["name"];
    password = json["password"];
    phone = json["phone"];
    secoundPhone = json["secoundPhone"];
    email = json["email"];
    isAdmin = json["isAdmin"];
    points = (json["points"] as num).toInt();
    wallet = (json["wallet"] as num).toDouble();
    otp = json["otp"];
    verified = json["verified"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = (json["__v"] as num).toInt();
  }
}

class Address1ForOrderDetails {
  String? city;
  String? governorate;
  String? street;
  String? homeNumber;
  String? floorNumber;
  String? flatNumber;
  String? description;

  Address1ForOrderDetails(
      {this.city,
      this.governorate,
      this.street,
      this.homeNumber,
      this.floorNumber,
      this.flatNumber,
      this.description});

  Address1ForOrderDetails.fromJson(Map<String, dynamic> json) {
    city = json["city"];
    governorate = json["governorate"];
    street = json["street"];
    homeNumber = json["homeNumber"];
    floorNumber = json["floorNumber"];
    flatNumber = json["flatNumber"];
    description = json["description"];
  }
}

class AddressForOrderDetails {
  String? city;
  String? governorate;
  String? street;
  String? homeNumber;
  String? floorNumber;
  String? flatNumber;
  String? description;

  AddressForOrderDetails(
      {this.city,
      this.governorate,
      this.street,
      this.homeNumber,
      this.floorNumber,
      this.flatNumber,
      this.description});

  AddressForOrderDetails.fromJson(Map<String, dynamic> json) {
    city = json["city"];
    governorate = json["governorate"];
    street = json["street"];
    homeNumber = json["homeNumber"];
    floorNumber = json["floorNumber"];
    flatNumber = json["flatNumber"];
    description = json["description"];
  }
}
