import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';

class ConstantString {
  static String networkMsg = 'messages_no_network';
  static String phoneMsg = 'messages_not_a_valid_phone';
  static String emailVerificationMsg = 'messages_email_not_verified';
  static String privacyMsg = 'messages_privacy_policy_and_terms_and_services';
}

String getMessage(BuildContext context, String errorMsg) {
  switch (errorMsg) {
    case "messages_no_network":
      return "messages_no_network".tr(context);
    case "messages_email_not_verified":
      return "messages_email_not_verified".tr(context);
    default:
      return errorMsg;
  }
}


