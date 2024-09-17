import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cars_equipments_shop/core/functions/navigation.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';

import 'package:cars_equipments_shop/core/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/shared/data/local/shared_local.dart';
import '../../data/local/onboarding_local.dart';
import '../widgets/onboarding_3dmodel_widget.dart';
import '../widgets/onboarding_subtitle_widget.dart';
import '../widgets/onboarding_title_widget.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final List<String> titles;
  late final List<String> subtitles;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    subtitles = [
      OnBoardingConstants.onboarding1Subtitle.tr(context),
      OnBoardingConstants.onboarding2Subtitle.tr(context),
      OnBoardingConstants.onboarding3Subtitle.tr(context),
    ];
    titles = [
      OnBoardingConstants.onboarding1Title.tr(context),
      OnBoardingConstants.onboarding2Title.tr(context),
      OnBoardingConstants.onboarding3Title.tr(context),
    ];
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % titles.length;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Onboarding3dModelWidget(model3D: TImages.onboardingCar),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  key: ValueKey<int>(_currentIndex),
                  children: [
                    OnboardingTitleWidget(animatedTexts: titles[_currentIndex]),
                    OnboardingSubtitleWidget(
                      animatedTexts: [
                        TypewriterAnimatedText(subtitles[_currentIndex])
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtnItems),
              ElevatedButton(
                onPressed: () async {
                  pushNamedAndRemoveUntil(
                    context,
                    PagesName.loginPage,
                    false,
                  );
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString("step", "1");
                },
                child: Text(OnBoardingConstants.letsStart.tr(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
