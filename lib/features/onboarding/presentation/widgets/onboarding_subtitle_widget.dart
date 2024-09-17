import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


class OnboardingSubtitleWidget extends StatelessWidget {
  const OnboardingSubtitleWidget({
    super.key,
    required this.animatedTexts,
  });
  final List<AnimatedText> animatedTexts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: DefaultTextStyle(
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontSize: 18, fontWeight: FontWeight.normal),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: animatedTexts,
        ),
      ),
    );
  }
}
