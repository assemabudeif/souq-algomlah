import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String city;
  final String cityEnglish;
  final String governorate;
  final String street;
  final String homeNumber;
  final String floorNumber;
  final String flatNumber;
  final String description;

  const AddressModel({
    required this.city,
    this.cityEnglish = "",
    required this.governorate,
    required this.street,
    required this.homeNumber,
    required this.floorNumber,
    required this.flatNumber,
    required this.description,
  });

  /// CopyWith method to update the model
  AddressModel copyWith({
    String? city,
    String? cityEnglish,
    String? governorate,
    String? street,
    String? homeNumber,
    String? floorNumber,
    String? flatNumber,
    String? description,
  }) {
    return AddressModel(
      city: city ?? this.city,
      cityEnglish: cityEnglish ?? this.cityEnglish,
      governorate: governorate ?? this.governorate,
      street: street ?? this.street,
      homeNumber: homeNumber ?? this.homeNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      flatNumber: flatNumber ?? this.flatNumber,
      description: description ?? this.description,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        city: json["city"] ?? "",
        governorate: json["governorate"] ?? "",
        street: json["street"] ?? "",
        homeNumber: json["homeNumber"] ?? "",
        floorNumber: json["floorNumber"] ?? "",
        flatNumber: json["flatNumber"] ?? "",
        description: json["description"] ?? "",
      );

  @override
  List<Object?> get props => [
        city,
        cityEnglish,
        governorate,
        street,
        homeNumber,
        floorNumber,
        flatNumber,
        description,
      ];

  Map<String, dynamic> toJson() => {
        "city": city,
        "governorate": governorate,
        "street": street,
        "homeNumber": homeNumber,
        "floorNumber": floorNumber,
        "flatNumber": flatNumber,
        "description": description,
      };
}
