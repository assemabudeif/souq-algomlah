import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension TextThemeInContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ThemeInContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension SizeInContext on BuildContext {
  Size get size => MediaQuery.of(this).size;
}

extension PaddingInContext on BuildContext {
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension MediaQueryInContext on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension NavigateToInContext on BuildContext {
  void navigateTo(Widget route) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
  }
}

extension NavigateToNamedInContext on BuildContext {
  void navigateToNamed(String routeName) {
    Navigator.of(this).pushNamed(routeName);
  }
}

extension NavigateToInContextWithArguments on BuildContext {
  void navigateToNamedWithArguments(String routeName, Object arguments) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
}

extension NavigateToInContextWithReplacement on BuildContext {
  void navigateToNamedWithReplacement(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }
}

extension NavigateToInContextWithReplacementAndArguments on BuildContext {
  void navigateToNamedWithReplacementAndArguments(
      String routeName, Object arguments) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }
}

extension NavigateToInContextWithPopUntil on BuildContext {
  void navigateToNamedWithPopUntil(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}

extension NavigateToInContextWithPopUntilAndArguments on BuildContext {
  void navigateToNamedWithPopUntilAndArguments(
      String routeName, Object arguments) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false,
        arguments: arguments);
  }
}

extension PopInContext on BuildContext {
  void pop() {
    Navigator.of(this).pop();
  }
}

extension PopUntilInContext on BuildContext {
  void popUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }
}

extension ShowSuccessSnackBarInContext on BuildContext {
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.successColor,
      ),
    );
  }
}

extension ShowErrorSnackBarInContext on BuildContext {
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.dangerColor,
      ),
    );
  }
}

extension ShowWarningSnackBarInContext on BuildContext {
  void showWarningSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.warningColor,
      ),
    );
  }
}

extension ShowSnackBarInContext on BuildContext {
  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
