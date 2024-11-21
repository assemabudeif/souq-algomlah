import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/theme/app_color.dart';
import '/core/services/services_locator.dart';
import '/features/onboarding/viewmodel/on_boarding_cubit.dart';
import '/features/onboarding/views/widgets/on_boarding_footer_widget.dart';
import '/features/onboarding/views/widgets/on_boarding_header_widget.dart';
import 'widgets/on_boarding_page_widget.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final _vm = sl<OnBoardingCubit>();
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        _vm.nextPage();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnBoardingCubit>(
      create: (context) => _vm,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              const OnBoardingHeaderWidget(),
              OnBoardingPageWidget(vm: _vm),
              OnBoardingFooterWidget(vm: _vm),
            ],
          ),
        ),
      ),
    );
  }
}
