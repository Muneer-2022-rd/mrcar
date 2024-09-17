import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/widgets/custome_seaction_heading.dart';
import '../../data/local/settings_local.dart';
import '../cubit/settings_cubit.dart';
import 'change_app_language_widget.dart';
import 'change_app_theme_widget.dart';
import 'custome_setting_menu_tile.dart';

class AppSettingsWidget extends StatefulWidget {
  const AppSettingsWidget({super.key});

  @override
  State<AppSettingsWidget> createState() => _AppSettingsWidgetState();
}

class _AppSettingsWidgetState extends State<AppSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomeSeactionHeading(
            title:
                "${SettingsConstants.settingsAppTitle.tr(context)} ${SettingsConstants.settingsTitle.tr(context)}"),
        const SizedBox(height: TSizes.spaceBtnItems / 2),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileLanguageTitle,
          subTitle:
              SettingsConstants.settingsListTileLanguageSubtitle,
          leadingIcon: Iconsax.language_square,
          onTap: () {
            showBottomSheet(
              builder: (context) {
                return const ChangeAppLanguageWidget();
              },
              context: context,
            );
          },
        ),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileThemeTitle,
          subTitle: SettingsConstants.settingsListTileThemeSubtitle,
          leadingIcon: Iconsax.edit,
          onTap: () {
            showBottomSheet(
              builder: (context) {
                return const ChangeAppThemeWidget();
              },
              context: context,
            );
          },
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return CustomeSettingMenuTile(
              title: SettingsConstants.settingsListTileNotificationsTitle
                  ,
              subTitle: SettingsConstants.settingsListTileNotificationsSubtitle
                  ,
              leadingIcon: Iconsax.notification,
              trailing: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Switch(
                    value: context.read<SettingsCubit>().notify,
                    onChanged: (value) => context
                        .read<SettingsCubit>()
                        .requestNotificationPermission(value),
                    activeTrackColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    activeColor: Theme.of(context).primaryColor,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}