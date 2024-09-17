import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/shared/widgets/custome_loading.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';

import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../bloc/login_bloc.dart';

class VerifyPhonePage extends StatefulWidget {
  final String verificationId;
  final String dialCode;
  final String phoneNumber;
  const VerifyPhonePage({
    super.key,
    required this.verificationId,
    required this.dialCode,
    required this.phoneNumber,
  });

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is PhoneLoginErrorState) {
          THelperFunctions.showSnackBar(
            context: context,
            title: SharedConstants.messageWrongAlertTitle.tr(context),
            message: state.errorMsg,
            type: ContentType.failure,
          );
          print(state.errorMsg);
        } else if (state is PhoneLoginSuccessState) {
          pushNamedAndRemoveUntil(
            context,
            PagesName.navigationMenuPage,
            false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomeAppBar(
            showBackArrow: true,
            title: Text(
              'Verify Phone',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Lottie.asset(TImages.verify),
                  Text(
                    "Please enter your phone number to sign in. We will send you a verification code to confirm your identity.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtnItems),
                  OTPTextFieldV2(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: MediaQuery.of(context).size.width * 0.11,
                    style: const TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    onCompleted: (pin) {
                      BlocProvider.of<LoginBloc>(context).add(PhoneSignInEvent(
                        id: widget.verificationId,
                        otp: pin,
                        phoneNmuber: widget.phoneNumber,
                        dialCode: widget.dialCode,
                      ));
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtnItems),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return state is PhoneLoginLoadingState
                          ? const LoadingWidget()
                          : const SizedBox.shrink();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
