import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/on_boarding/screen/onboarding3.dart';
import '../cubit/onboarding_cubit.dart';
import 'onboarding1.dart';
import 'onboarding2.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        OnboardingCubit cubit = context.read<OnboardingCubit>();
        return OrientationBuilder(
          builder: (context, orientation) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Flexible(
                    child: PageView(
                      controller: cubit.pageController,
                      reverse: false,
                      onPageChanged: (int page) {
                        cubit.onPageChanged(page);
                      },
                      children: const [
                        OnBoarding1(),
                        OnBoarding2(),
                        OnBoarding3(),
                      ],
                    ),
                  ),


                ],
              ),
            );
          },
        );
      },
    );
  }
}
