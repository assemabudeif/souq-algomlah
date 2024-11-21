import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String secondPhone;
  final String password;
  final String city;
  final String governorate;
  final String street;
  final String homeNumber;
  final String floorNumber;
  final String flatNumber;
  final String description;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.secondPhone,
    required this.password,
    required this.city,
    required this.governorate,
    required this.street,
    required this.homeNumber,
    required this.floorNumber,
    required this.flatNumber,
    required this.description,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        password,
        city,
        governorate,
        street,
        homeNumber,
        floorNumber,
        flatNumber,
        description,
      ];

  Map<String, dynamic> toJson() {
    return {
      if (name.isNotEmpty) 'name': name,
      if (email.isNotEmpty) 'email': email,
      if (phone.isNotEmpty) 'phone': phone,
      // if (secondPhone.isNotEmpty) 'secoundPhone': secondPhone,
      if (password.isNotEmpty) 'password': password,
      if (city.isNotEmpty ||
          governorate.isNotEmpty ||
          street.isNotEmpty ||
          homeNumber.isNotEmpty ||
          floorNumber.isNotEmpty ||
          flatNumber.isNotEmpty ||
          description.isNotEmpty)
        "address": {
          if (city.isNotEmpty) "city": city,
          if (governorate.isNotEmpty) "governorate": governorate,
          if (street.isNotEmpty) "street": street,
          if (homeNumber.isNotEmpty) "homeNumber": homeNumber,
          if (floorNumber.isNotEmpty) "floorNumber": floorNumber,
          if (flatNumber.isNotEmpty) "flatNumber": flatNumber,
          if (description.isNotEmpty) "description": description,
        }
    };
  }
}
