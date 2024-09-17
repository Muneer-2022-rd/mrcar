import 'package:cars_equipments_shop/core/constants/images.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../register/data/local/register_local.dart';
import 'verify_phone_page.dart';

class LoginByPhonePage extends StatefulWidget {
  const LoginByPhonePage({super.key});

  @override
  State<LoginByPhonePage> createState() => _LoginByPhonePageState();
}

class _LoginByPhonePageState extends State<LoginByPhonePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController userPhone;

  @override
  void dispose() {
    userPhone.dispose();
    super.dispose();
  }

  String? selectedCountryIsoCode = "971";
  changeSelectedCountryIsoCode(Country newSelectedCountryIsoCode) {
    setState(() {
      selectedCountryIsoCode = newSelectedCountryIsoCode.dialCode;
    });
  }

  SharedPreferences? sharedPreferences;
  String? lang;
  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    lang = sharedPreferences!.getString("LOCALE") ?? "en";
  }

  @override
  void initState() {
    super.initState();
    userPhone = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        showBackArrow: true,
        title: Text(
          'Phone SignIn',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset(TImages.phoneLottie),
              Text(
                "Please enter your phone number to sign in. We will send you a verification code to confirm your identity.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.spaceBtnItems),
              Form(
                key: _formKey,
                child: IntlPhoneField(
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    label: Text(
                      RegisterConstants.registerFormPhone.tr(context),
                    ),
                  ),
                  disableLengthCheck: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  validator: (value) {
                    if (value == null) {
                      return RegisterConstants.registerFormPhoneIsRequired
                          .tr(context);
                    } else {
                      return null;
                    }
                  },
                  pickerDialogStyle: PickerDialogStyle(),
                  initialCountryCode: selectedCountryIsoCode,
                  languageCode: lang ?? "en",
                  onCountryChanged: (value) =>
                      changeSelectedCountryIsoCode(value),
                  controller: userPhone,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtnItems),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber:
                        '+$selectedCountryIsoCode${userPhone.text}', // Full phone number
                    verificationCompleted:
                        (PhoneAuthCredential credential) async {
                      print("v__verificationCompleted");
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      print("v__verificationFailed");
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      print("v__codeSent");
                      push(
                        context,
                        VerifyPhonePage(
                          verificationId: verificationId,
                          dialCode: selectedCountryIsoCode!,
                          phoneNumber: userPhone.text,
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      print("v__codeAutoRetrievalTimeout");
                    },
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
