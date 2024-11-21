import 'package:equatable/equatable.dart';

class OnBoardingModel extends Equatable {
  final String image;
  final String title;

  const OnBoardingModel({
    required this.image,
    required this.title,
  });

  @override
  List<Object> get props => [image, title];
}
