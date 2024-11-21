import 'package:equatable/equatable.dart';
import '/core/data/models/address_model.dart';

class LoginModel extends Equatable {
  final String id;
  final String username;
  final String token;
  final double points;
  final double wallet;
  final AddressModel address;
  final bool isAdmin;
  final bool verified;
  final String phone;

  const LoginModel({
    required this.id,
    required this.username,
    required this.token,
    required this.points,
    required this.wallet,
    required this.address,
    required this.isAdmin,
    required this.verified,
    required this.phone,
  });

  /// CopyWith method to update the model
  LoginModel copyWith({
    String? id,
    String? username,
    String? token,
    double? points,
    double? wallet,
    AddressModel? address,
    bool? isAdmin,
    bool? verified,
    String? phone,
  }) {
    return LoginModel(
      id: id ?? this.id,
      username: username ?? this.username,
      token: token ?? this.token,
      points: points ?? this.points,
      wallet: wallet ?? this.wallet,
      address: address ?? this.address,
      isAdmin: isAdmin ?? this.isAdmin,
      verified: verified ?? this.verified,
      phone: phone ?? this.phone,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        phone: json["phone"] ?? "",
        token: json["token"] ?? "",
        points: double.parse((json["points"] ?? 0).toStringAsFixed(3)),
        wallet: double.parse((json["wallet"] ?? 0).toStringAsFixed(3)),
        address: AddressModel.fromJson(json["address"]),
        isAdmin: json["isAdmin"] ?? false,
        verified: json["verified"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone": phone,
        "token": token,
        "points": points,
        "wallet": wallet,
        "address": address.toJson(),
        "isAdmin": isAdmin,
        "verified": verified,
      };

  @override
  List<Object?> get props => [
        id,
        username,
        phone,
        token,
        points,
        wallet,
        address,
        isAdmin,
        verified,
      ];
}
