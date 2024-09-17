import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../data/local/register_local.dart';

class AdditionalInfoForm extends StatelessWidget {
  final DateTime? selectedDate;
  final String? userGender;
  final TextEditingController? userPhone;
  final String? lang;
  final Function selectDate;
  final Function changeGender;
  final Function changeSelectedCountryIsoCode;
  final String selectedCountryIsoCode;

  const AdditionalInfoForm({
    required this.selectedDate,
    required this.userGender,
    required this.userPhone,
    required this.lang,
    required this.selectDate,
    required this.changeGender,
    required this.changeSelectedCountryIsoCode,
    super.key,
    required this.selectedCountryIsoCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              return RegisterConstants.registerFormPhoneIsRequired.tr(context);
            } else if (value.completeNumber.length < 10) {
              return RegisterConstants.registerFormPhoneCantBeEmpty.tr(context);
            } else {
              return null;
            }
          },
          initialCountryCode: selectedCountryIsoCode,
          languageCode: lang ?? "en",
          onCountryChanged: (value) => changeSelectedCountryIsoCode(value),
          controller: userPhone,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: TColors.grey),
          ),
          child: DropdownButton(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            isExpanded: true,
            underline: const SizedBox.shrink(),
            hint: Row(
              children: <Widget>[
                const Icon(
                  Iconsax.profile_circle4,
                  color: Colors.black38,
                ),
                const SizedBox(width: 10),
                Text(
                  RegisterConstants.registerFormGender.tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
            value: userGender,
            items: RegisterConstants.genders
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e.gender,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          e.icon,
                          color: Colors.black38,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e.gender,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => changeGender(value),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => selectDate(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Iconsax.calendar_1,
                  color: Colors.black38,
                ),
                const SizedBox(width: 10),
                Text(
                  selectedDate == null
                      ? RegisterConstants.registerFormDateOfBirth.tr(context)
                      : THelperFunctions.getFormattedDate(selectedDate!),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
      ],
    );
  }
}
