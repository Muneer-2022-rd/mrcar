import 'dart:convert';

import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../../bloc/menu_bloc.dart';
import '../../data/local/settings_local.dart';
import 'custome_user_profile_tile.dart';
import 'custome_user_profile_tile_shimmer.dart';

class ProfileTileWidget extends StatefulWidget {
  const ProfileTileWidget({super.key});

  @override
  State<ProfileTileWidget> createState() => _ProfileTileWidgetState();
}

class _ProfileTileWidgetState extends State<ProfileTileWidget> {
  SharedPreferences? sharedPreferences;
  Map<String, dynamic> cachedUser = {};

  Future<void> _initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      final cachedUserString =
          sharedPreferences?.getString('userSettings') ?? '';
      if (cachedUserString.isNotEmpty) {
        cachedUser = jsonDecode(cachedUserString);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // Method to build the user profile tile based on provider type
  Widget _buildUserProfileTile() {
    final isPhoneUser = cachedUser['provider_type'] == 'phone';
    final subTitle = isPhoneUser
        ? '${cachedUser['user_phone']['country_code']}${cachedUser['user_phone']['phone_number']}'
        : cachedUser['user_email'];

    return CustomeUserProfileTile(
      title: cachedUser['user_name'],
      subTitle: subTitle,
      imagePath: cachedUser['user_image'],
      onPressed: () => pushNamed(context, PagesName.profilePage),
      icon: const Icon(Iconsax.edit, color: TColors.white),
    );
  }

  // Method to handle different states and return the corresponding widget
  Widget _buildContentBasedOnState(MenuState state) {
    if (state is FetchUserSettingsDataLoadingState && cachedUser.isNotEmpty) {
      return _buildUserProfileTile();
    }

    if (state is FetchUserSettingsDataSuccessState ||
        state is FetchUserSettingsDataNoInternetConnection) {
      return _buildUserProfileTile();
    }

    return CustomeUserProfileTileShimmer(
      onPressed: () => pushNamed(context, PagesName.profilePage),
      icon: const Icon(Iconsax.edit, color: TColors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomeAppBar(
              title: Text(
                SettingsConstants.settingsAccountTitle.tr(context),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: Colors.white),
              ),
            ),
            _buildContentBasedOnState(state),
            const SizedBox(height: TSizes.spaceBtnSections),
          ],
        );
      },
    );
  }
}
