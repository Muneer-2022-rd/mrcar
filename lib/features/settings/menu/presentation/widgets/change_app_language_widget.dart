import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../lang/cubit/locale_cubit.dart';
import '../../data/local/settings_local.dart';
import '../../../../../core/shared/widgets/custome_seaction_heading.dart';

class ChangeAppLanguageWidget extends StatelessWidget {
  const ChangeAppLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomeSeactionHeading(
                title:
                    "${SharedConstants.sharedChange.tr(context)} ${SettingsConstants.settingsListTileLanguageTitle.tr(context)}",
              ),
              const SizedBox(height: TSizes.spaceBtnItems / 2),
              BlocBuilder<LocaleCubit, ChangeLocaleState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: TSizes.defaultSpace,
                            right: TSizes.defaultSpace / 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: TColors.grey),
                          ),
                          child: DropdownButton<String>(
                            value: state.locale.languageCode,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            style: Theme.of(context).textTheme.bodyLarge,
                            underline: const SizedBox.shrink(),
                            hint: Text(
                              "Change Language",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            items: ['ar', 'en'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                context
                                    .read<LocaleCubit>()
                                    .changeLanguage(newValue);

                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
