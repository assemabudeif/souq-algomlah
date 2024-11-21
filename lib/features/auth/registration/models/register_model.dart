import 'package:equatable/equatable.dart';

class RewgisterModel extends Equatable {
  final String id;
  final String name;

  const RewgisterModel({
    required this.id,
    required this.name,
  });

  factory RewgisterModel.fromJson(Map<String, dynamic> json) {
    return RewgisterModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}
