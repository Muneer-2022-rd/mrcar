import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_seaction_heading.dart';
import '../../data/local/settings_local.dart';
import 'custome_setting_menu_tile.dart';

class AccountSettingsWidget extends StatelessWidget {
  const AccountSettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomeSeactionHeading(
          title:
              "${SettingsConstants.settingsAccountTitle.tr(context)} ${SettingsConstants.settingsTitle.tr(context)}",
        ),
        const SizedBox(height: TSizes.spaceBtnItems / 2),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileMyWishlistTitle,
          subTitle:
              SettingsConstants.settingsListTileMyWishlistSubtitle,
          leadingIcon: Iconsax.heart,
          onTap: () async {},
        ),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileMyOrdersTitle,
          subTitle:
              SettingsConstants.settingsListTileMyOrdersSubtitle,
          leadingIcon: Iconsax.box,
          onTap: () async {},
        ),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileMyAddressesTitle,
          subTitle:
              SettingsConstants.settingsListTileMyAddressesSubtitle,
          leadingIcon: Iconsax.location,
          onTap: () async {
            pushNamed(context, PagesName.addressPage);
          },
        ),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileMyCarsTitle,
          subTitle:
              SettingsConstants.settingsListTileMyCarsSubtitle,
          leadingIcon: Iconsax.car,
          onTap: () async {},
        ),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileMyWorkshopsTitle,
          subTitle:
              SettingsConstants.settingsListTileMyWorkshopsSubtitle,
          leadingIcon: Iconsax.building,
          onTap: () async {
            pushNamed(context, PagesName.myShops);
          },
        ),
        CustomeSettingMenuTile(
          title:
              SettingsConstants.settingsListTileMyEquipmentsTitle,
          subTitle: SettingsConstants.settingsListTileMyEquipmentsSubtitle
              ,
          leadingIcon: Iconsax.setting_24,
          onTap: () async {},
        ),
        CustomeSettingMenuTile(
          title: SettingsConstants.settingsListTileUploadDummayDataTitle
              ,
          subTitle: SettingsConstants.settingsListTileUploadDummayDataSubtitle
              ,
          leadingIcon: Iconsax.document_upload,
          onTap: () async {},
        ),
        const SizedBox(height: TSizes.spaceBtnItems / 2),
      ],
    );
  }
}
