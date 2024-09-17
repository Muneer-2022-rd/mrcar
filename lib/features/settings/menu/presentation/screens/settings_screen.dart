import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../bloc/menu_bloc.dart';
import '../widgets/account_settings_widget.dart';
import '../widgets/app_settings_widget.dart';
import '../widgets/custome_primary_header_container.dart';
import '../widgets/profile_tile_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _onRefresh() async {
    BlocProvider.of<MenuBloc>(context).add(FetchUserSettingsDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: BlocListener<MenuBloc, MenuState>(
              listener: (context, state) {
                if (state is FetchUserSettingsDataErrorState) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    title: SharedConstants.messageWrongAlertTitle.tr(context),
                    message: state.errorMsg,
                    type: ContentType.failure,
                  );
                } else if (state is FetchUserSettingsDataSuccessState) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    title: SharedConstants.messageSuccessAlertTitle.tr(context),
                    message:
                        SharedConstants.sharedFetchedSuccessfully.tr(context),
                    type: ContentType.success,
                  );
                } else if (state is FetchUserSettingsDataNoInternetConnection) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    message:
                        SharedConstants.messageNoInternetConnection.tr(context),
                    title: SharedConstants.messageAlertTitle.tr(context),
                    type: ContentType.warning,
                  );
                }
              },
              child: const Column(
                children: [
                  CustomePrimaryHeaderContainer(
                    child: ProfileTileWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        AccountSettingsWidget(),
                        AppSettingsWidget(),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
