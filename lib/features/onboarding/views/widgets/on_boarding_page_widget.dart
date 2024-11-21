import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/onboarding/viewmodel/on_boarding_cubit.dart';

import '/features/onboarding/views/widgets/on_boarding_page_item_widget.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({super.key, required this.vm});

  final OnBoardingCubit vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      bloc: vm,
      builder: (context, state) {
        return Expanded(
          child: PageView.builder(
            onPageChanged: (index) {
              vm.onPageChanged(index);
            },
            controller: vm.pageController,
            itemCount: vm.onBoardingPages.length,
            itemBuilder: (context, index) {
              return OnBoardingPageItemWidget(
                image: vm.onBoardingPages[index].image,
                title: vm.onBoardingPages[index].title,
              );
            },
          ),
        );
      },
    );
  }
}
