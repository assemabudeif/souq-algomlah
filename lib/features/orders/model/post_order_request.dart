class PostOrderRequest {
  final String phone;
  final Address address;
  final List<Cart> cart;
  final bool onlinePay;

  PostOrderRequest(
      {required this.phone,
      required this.address,
      required this.cart,
      required this.onlinePay});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["phone"] = phone.toString();
   
      data["address"] = address.toJson();
    
  
      data["cart"] = cart.map((e) => e.toJson()).toList();
    
    data["onlinePay"] = onlinePay;
    return data;
  }
}

class Cart {
  final String product;
  final int amount;

  Cart({required this.product, required this.amount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product"] = product;
    data["amount"] = amount;
    return data;
  }
}
class Address {
    String? city;
    String? governorate;
    String? street;
    String? homeNumber;
    String? floorNumber;
    String? flatNumber;
    String? description;

    Address({this.city, this.governorate, this.street, this.homeNumber, this.floorNumber, this.flatNumber, this.description});

    Address.fromJson(Map<String, dynamic> json) {
        city = json["city"];
        governorate = json["governorate"];
        street = json["street"];
        homeNumber = json["homeNumber"];
        floorNumber = json["floorNumber"];
        flatNumber = json["flatNumber"];
        description = json["description"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["city"] = city;
        data["governorate"] = governorate;
        data["street"] = street;
        data["homeNumber"] = homeNumber;
        data["floorNumber"] = floorNumber;
        data["flatNumber"] = flatNumber;
        data["description"] = description;
        return data;
    }
}