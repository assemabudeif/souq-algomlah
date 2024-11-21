import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String publicId;
  final String url;

  const ImageModel({
    required this.publicId,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        publicId: json["public_id"] ?? '',
        url: json["url"] ?? '',
      );

  @override
  List<Object?> get props => [
        publicId,
        url,
      ];
}
