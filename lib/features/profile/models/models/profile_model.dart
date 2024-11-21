import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends Equatable {
  final IconData icon;
  final String title;
  final Function onPressed;

  const ProfileViewModel({
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  List<Object> get props => [icon, title, onPressed];
}
