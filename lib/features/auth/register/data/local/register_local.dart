import 'package:iconsax/iconsax.dart';

import '../models/gender_model.dart';

class RegisterConstants {
  static List<GenderModel> genders = [
    GenderModel(gender: 'male', icon: Iconsax.user),
    GenderModel(gender: 'female', icon: Iconsax.user),
  ];

  static String registerFormFirstName = "register_form_first_name";
  static String registerFormLastName = "register_form_last_name";
  static String registerFormUserName = "register_form_user_name";
  static String registerFormPhone = "register_form_phone";
  static String registerFormPhoneIsRequired = "register_form_phone_is_required";
  static String registerFormPhoneCantBeEmpty =
      "register_form_phone_cant_be_empty";
  static String registerFormGender = "register_form_gender";
  static String registerFormDateOfBirth = "register_form_date_of_birth";
  static String registerFormAgree = "register_form_agree";
  static String registerFormPrivacy = "register_form_privacy";
  static String registerFormAnd = "register_form_and";
  static String registerFormTerms = "register_form_terms";
  static String registerSuccess = "register_success";
  static String registerError = "register_error";
  static String registerAlreadyHaveAnAccount =
      "register_already_have_an_account";
  static String registerCheckEmailValidationLink =
      "register_check_email_validation_link";
  static String registerContinue = "register_continue";
  static String registerAgain = "register_again";
  static String registerEmailVerifyedSuccessfully =
      "register_email_verified_successfully";
  static String registerEmailVerifyedTitle = "register_email_verified_title";

  static String registerFormPrivacyPolicyAndTermsAndServices = "register_form_privacy_policy_and_terms_and_services";
  static String registerFormFieldsRequired = "register_form_fields_required";
}
