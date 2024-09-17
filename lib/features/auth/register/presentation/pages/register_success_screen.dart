import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/functions/navigation.dart';
import 'package:cars_equipments_shop/core/shared/widgets/custome_app_bar.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../core/constants/images.dart';
import '../../../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../data/local/register_local.dart';
import '../bloc/register_bloc.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/shared/widgets/custome_loading.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Iconsax.close_circle,
              size: 45,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is CheckValidationErrorState) {
            THelperFunctions.showSnackBar(
              context: context,
              title: SharedConstants.messageWrongAlertTitle.tr(context),
              message: getMessage(context, state.errorMsg),
              type: ContentType.failure,
            );
          } else if (state is CheckValidationSuccessState) {
            pushNamed(context, PagesName.loginPage,);
            THelperFunctions.showSnackBar(
              context: context,
              title: RegisterConstants.registerEmailVerifyedTitle.tr(context),
              message: RegisterConstants.registerEmailVerifyedSuccessfully.tr(context),
              type: ContentType.success,
            );
          } else if (state is NoInternetConnectionState) {
            THelperFunctions.showSnackBar(
              context: context,
              title: SharedConstants.messageWrongAlertTitle.tr(context),
              message: SharedConstants.messageNoInternetConnection.tr(context),
              type: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: TSizes.edgeInsets * 2,
              child: Column(
                children: [
                  Lottie.asset(
                    TImages.success,
                    width: THelperFunctions.screenWidth(context) * 0.6,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtnSections,
                  ),
                  Text(
                    RegisterConstants.registerSuccess.tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtnItems),
                  Text(
                    RegisterConstants.registerCheckEmailValidationLink
                        .tr(context),
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtnSections,
                  ),
                  if (state is CheckValidationLoadingState) ...[
                    const LoadingWidget()
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RegisterBloc>(context)
                              .add(CheckEmailValidationEvent());
                        },
                        child: Text(
                          RegisterConstants.registerContinue.tr(context),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}