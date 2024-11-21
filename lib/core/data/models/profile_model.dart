import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final String? phone;
  final String? secondPhone;
  final double? points;
  final double? wallet;

  const ProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.secondPhone,
    required this.points,
    required this.wallet,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        secondPhone: json["secoundPhone"] ?? "",
        points: double.parse((json["points"] ?? 0.0).toStringAsFixed(3)),
        wallet: double.parse((json["wallet"] ?? 0.0).toStringAsFixed(3)),
      );

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        phone,
        secondPhone,
        points,
        wallet,
      ];
}
