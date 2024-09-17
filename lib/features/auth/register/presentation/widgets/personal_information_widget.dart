import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_text_form_field.dart';
import '../../../../../core/validation/validator.dart';
import '../../data/local/register_local.dart';

class PersonalInfoForm extends StatelessWidget {
  final TextEditingController userFirst;
  final TextEditingController userLast;
  final TextEditingController userName;
  final TextEditingController userEmail;
  final TextEditingController userPassword;
  final bool showHiddenPassword;
  final Function toggolePasswordEvent;

  const PersonalInfoForm({
    required this.userFirst,
    required this.userLast,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.showHiddenPassword,
    required this.toggolePasswordEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: TSizes.spaceBtwInputFields),
        Row(
          children: [
            Expanded(
              child: CustomeTextFormField(
                labelText: RegisterConstants.registerFormFirstName.tr(context),
                prefixIcon: Icons.person_2_outlined,
                keyboardType: TextInputType.text,
                controller: userFirst,
                validator: (value) => TValidator.validateField(value),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: CustomeTextFormField(
                labelText: RegisterConstants.registerFormLastName.tr(context),
                prefixIcon: Icons.person_2_outlined,
                keyboardType: TextInputType.text,
                controller: userLast,
                validator: (value) => TValidator.validateField(value),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        CustomeTextFormField(
          labelText: RegisterConstants.registerFormUserName.tr(context),
          prefixIcon: Icons.verified_user_outlined,
          keyboardType: TextInputType.text,
          controller: userName,
          validator: (value) => TValidator.validateField(value),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        CustomeTextFormField(
          labelText: SharedConstants.sharedFormEmail.tr(context),
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          controller: userEmail,
          validator: (value) => TValidator.validateEmail(value),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        TextFormField(
          validator: (value) => TValidator.validatePassword(value),
          controller: userPassword,
          keyboardType: TextInputType.text,
          obscureText: showHiddenPassword,
          style: const TextStyle().copyWith(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: TColors.black,
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: showHiddenPassword
                  ? const Icon(Iconsax.eye)
                  : const Icon(Iconsax.eye_slash),
              onPressed: () => toggolePasswordEvent(),
            ),
            label: Text(SharedConstants.sharedFormPassword.tr(context)),
            prefixIcon: const Icon(Icons.fingerprint),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
      ],
    );
  }
}