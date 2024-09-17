import 'package:flutter/material.dart';


class OnboardingTitleWidget extends StatelessWidget {
  const OnboardingTitleWidget({
    super.key,
    required this.animatedTexts,
  });
  final String animatedTexts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: DefaultTextStyle(
        textAlign: TextAlign.start,
        style:
            Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 30),
        child: Text(animatedTexts),
      ),
    );
  }
}
