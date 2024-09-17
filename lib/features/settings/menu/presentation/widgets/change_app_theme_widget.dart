import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:cars_equipments_shop/features/settings/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/theme/theme.dart';
import '../../data/local/settings_local.dart';
import '../../../../../core/shared/widgets/custome_seaction_heading.dart';

class ChangeAppThemeWidget extends StatelessWidget {
  const ChangeAppThemeWidget({
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
                    "${SharedConstants.sharedChange.tr(context)} ${SettingsConstants.settingsListTileThemeTitle.tr(context)}",
              ),
              const SizedBox(height: TSizes.spaceBtnItems / 2),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: AppTheme.values.length,
                itemBuilder: (context, index) {
                  final itemAppTheme = AppTheme.values[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                        onTap: () {
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChangedEvent(theme: itemAppTheme));
                        Navigator.of(context).pop();
                        },
                        child: itemAppTheme.name.contains('Dark')
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                        border: Border.all(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            appTheme[itemAppTheme]!.primaryColor,
                                        borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            appTheme[itemAppTheme]!.primaryColor,
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(20),
                                        ),
                                        border: Border.all(),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
