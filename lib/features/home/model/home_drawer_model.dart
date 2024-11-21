import 'package:equatable/equatable.dart';

class HomeDrawerModel extends Equatable {
  final String title;
  final String icon;
  final String route;
  final Function? onTap;

  const HomeDrawerModel({
    required this.title,
    required this.icon,
    this.route = '',
    this.onTap,
  });

  @override
  List<Object> get props => [
        title,
        icon,
        route,
        onTap!,
      ];
}
