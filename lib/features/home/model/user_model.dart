import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final Address address;
  final String id;
  final String name;
  final String phone;
  final String secoundPhone;
  final String email;
  final bool isAdmin;
  final double points;
  final double wallet;
  final String otp;
  final bool verified;

  const UserModel({
    required this.address,
    required this.id,
    required this.name,
    required this.phone,
    required this.secoundPhone,
    required this.email,
    required this.isAdmin,
    required this.points,
    required this.wallet,
    required this.otp,
    required this.verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        address: Address.fromJson(json["address"]),
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        secoundPhone: json["secoundPhone"] ?? "",
        email: json["email"] ?? "",
        isAdmin: json["isAdmin"] ?? false,
        points: double.parse((json["points"] ?? 0.0).toStringAsFixed(3)),
        wallet: double.parse((json["wallet"] ?? 0.0).toStringAsFixed(3)),
        otp: json["otp"] ?? "",
        verified: json["verified"] ?? false,
      );

  @override
  List<Object> get props => [
        address,
        id,
        name,
        phone,
        secoundPhone,
        email,
        isAdmin,
        points,
        wallet,
        otp,
        verified,
      ];
}

class Address extends Equatable {
  final String city;
  final String governorate;
  final String street;
  final String homeNumber;
  final String floorNumber;
  final String flatNumber;

  const Address({
    required this.city,
    required this.governorate,
    required this.street,
    required this.homeNumber,
    required this.floorNumber,
    required this.flatNumber,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"] ?? "",
        governorate: json["governorate"] ?? "",
        street: json["street"] ?? "",
        homeNumber: json["homeNumber"] ?? "",
        floorNumber: json["floorNumber"] ?? "",
        flatNumber: json["flatNumber"] ?? "",
      );

  @override
  List<Object> get props => [
        city,
        governorate,
        street,
        homeNumber,
        floorNumber,
        flatNumber,
      ];
}
