import 'package:equatable/equatable.dart';

class MainBannerModel extends Equatable {
  final String publicId;
  final String url;

  const MainBannerModel({
    required this.publicId,
    required this.url,
  });

  factory MainBannerModel.fromJson(Map<String, dynamic> json) =>
      MainBannerModel(
        publicId: json["public_id"] ?? "",
        url: json["url"],
      );

  @override
  List<Object> get props => [publicId, url];
}
