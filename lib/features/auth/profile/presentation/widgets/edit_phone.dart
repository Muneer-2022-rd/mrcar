import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../../core/shared/widgets/custome_loading.dart';
import '../../../register/data/local/register_local.dart';
import '../../data/local/profile_local.dart';
import '../../data/models/user_model.dart';
import '../blocs/profile_oberations_bloc/edit_bloc.dart';

class EditPhone extends StatefulWidget {
  const EditPhone({super.key, required this.phone, required this.onPhoneUpdated});
  final PhoneNumberModel phone;
  final Function(String, String) onPhoneUpdated;

  @override
  State<EditPhone> createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {
  late TextEditingController phoneC;
  String? selectedCountryIsoCode;
  changeSelectedCountryIsoCode(Country newSelectedCountryIsoCode) {
    setState(() {
      selectedCountryIsoCode = newSelectedCountryIsoCode.code;
    });
  }

  @override
  void initState() {
    super.initState();
    phoneC = TextEditingController(text: widget.phone.phoneNumber);
    selectedCountryIsoCode = widget.phone.countryCode;
  }

  @override
  void dispose() {
    phoneC.dispose();
    super.dispose();
  }

  SharedPreferences? sharedPreferences;
  String? lang;
  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    lang = sharedPreferences!.getString("LOCALE") ?? "en";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          "Change Phone",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
        
      ),
      body: BlocConsumer<ProfileOperationsBloc, ProfileOperationsBlocState>(
        listener: (context, state) async {
          if (state is UpdateValueErrorState) {
            THelperFunctions.showSnackBar(
              context: context,
              message: state.errorMsg,
              title: SharedConstants.messageWrongAlertTitle.tr(context),
              type: ContentType.failure,
            );
          } else if (state is UpdateValueSuccessState) {
            THelperFunctions.showSnackBar(
              context: context,
              message: SharedConstants.sharedUpdateSuccessfully.tr(context),
              title: SharedConstants.messageSuccessAlertTitle.tr(context),
              type: ContentType.success,
            );
            widget.onPhoneUpdated(phoneC.text.trim(), selectedCountryIsoCode!.trim());
            Navigator.of(context).pop();

          } else if (state is EditProfileBlocNoInternetConnectionState) {
            THelperFunctions.showSnackBar(
              context: context,
              title: SharedConstants.messageWrongAlertTitle.tr(context),
              message: SharedConstants.messageNoInternetConnection.tr(context),
              type: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: TSizes.edgeInsets,
                  child: Column(
                    children: [
                      const Text(
                        "Choose Phone For Easy Verifiaction, This Phone Will Appear In Several Pages",
                      ),
                      const SizedBox(height: TSizes.spaceBtnSections),
                      IntlPhoneField(
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
                          } else if (value.completeNumber.length < 10) {
                            return RegisterConstants
                                .registerFormPhoneCantBeEmpty
                                .tr(context);
                          } else {
                            return null;
                          }
                        },
                        initialCountryCode: selectedCountryIsoCode,
                        languageCode: lang ?? "en",
                        onCountryChanged: (value) =>
                            changeSelectedCountryIsoCode(value),
                        controller: phoneC,
                      ),
                      const SizedBox(height: TSizes.spaceBtnSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<ProfileOperationsBloc>(context).add(
                              UpdateSingleFieldEvent(
                                newValue: PhoneNumberModel(
                                  phoneNumber: phoneC.text.trim(),
                                  countryCode: selectedCountryIsoCode!.trim(),
                                ).toJson(),
                              ),
                            );
                          },
                          child: state is UpdateValueLoadingState
                              ? const LoadingWidget(
                                  width: 25,
                                  height: 25,
                                  color: Colors.white,
                                )
                              : Text(ProfileConstants.profileEdit.tr(context)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
