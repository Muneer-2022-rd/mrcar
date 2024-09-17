import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';

class THelperFunctions {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required String title,
    required ContentType type,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showAlert({
    required BuildContext context,
    required String title,
    required String desc,
    required DialogType dialogType,
    void Function()? btnCancelOnPress,
    void Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
      btnCancelColor: Colors.red,
      btnOkColor: Colors.green,
    ).show();
  }

  static void openLoadingDialog(
    String text,
    String animation,
    BuildContext context,
  ) {
    final dark = THelperFunctions.isDarkMode(context);
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => PopScope(
        canPop: false,
        child: Container(
          color: dark ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              LottieBuilder.asset(
                animation,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static String truncateText(String text, int maxLenth) {
    if (text.length <= maxLenth) {
      return text;
    } else {
      return text.substring(0, maxLenth);
    }
  }

  static launchUrlEvent(String path, BuildContext context) async {
    Uri url = Uri.parse(path);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showAlert(
        context: context,
        title: path,
        desc: "unfortunatelyCouldNotLaunch".tr(context),
        dialogType: DialogType.error,
      );
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  static String getOrderState(String status) {
    return status == 'OrderStatus.deliverd'
        ? 'Delivered'
        : status == 'OrderStatus.shipped'
            ? 'Shipment on the way'
            : status == 'OrderStatus.canceled'
                ? "Canceled"
                : 'Processing';
  }

  static String getOrderId(String id) {
    String removeLeft = id.replaceAll('[', '');
    String removeRigth = removeLeft.replaceAll(']', '');
    return removeRigth;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }

  static String getMessageSentFormattedDate({
    required BuildContext context,
    required String sent,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(sent));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String? calculateSalePercentage({
    required double originalPrice,
    required double? salePrice,
  }) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  static String? calculateSalePrice({
    required double originalPrice,
    required double salePercentage,
  }) {
    if (originalPrice <= 0.0 || salePercentage <= 0.0) {
      return originalPrice.toStringAsFixed(2);
    }
    double discountAmount = (originalPrice * salePercentage) / 100;
    double salePrice = originalPrice - discountAmount;
    print(salePrice.toStringAsFixed(2));
    return salePrice.toStringAsFixed(2);
  }

  static String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = getFormattedDate(now);
    return formattedDate;
  }
}
