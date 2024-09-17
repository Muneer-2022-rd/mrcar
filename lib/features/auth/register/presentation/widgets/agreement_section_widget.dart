import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../data/local/register_local.dart';

class AgreementSection extends StatelessWidget {
  final bool isChecked;
  final Function toggoleRememberMeEvent;

  const AgreementSection({
    required this.isChecked,
    required this.toggoleRememberMeEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.start,
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) async {
                toggoleRememberMeEvent();
              },
              activeColor: Theme.of(context).primaryColor,
            ),
            Text(
              RegisterConstants.registerFormAgree.tr(context),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
              overflow: TextOverflow.visible,
            ),
            InkWell(
              onTap: () async =>
                  THelperFunctions.launchUrlEvent("www.google.com", context),
              child: Text(
                RegisterConstants.registerFormPrivacy.tr(context),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    decoration: TextDecoration.underline, fontSize: 14),
                overflow: TextOverflow.visible,
              ),
            ),
            Text(
              RegisterConstants.registerFormAnd.tr(context),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
              overflow: TextOverflow.visible,
            ),
            InkWell(
              onTap: () async =>
                  THelperFunctions.launchUrlEvent("www.google.com", context),
              child: Text(
                RegisterConstants.registerFormTerms.tr(context),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    decoration: TextDecoration.underline, fontSize: 14),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
      ],
    );
  }
}
