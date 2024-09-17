import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/widgets/custome_text_field_with_svg_picture_widget.dart';
import '../../../../../core/validation/validator.dart';
import '../../../data/local/address_local.dart';

class AddressFormFields extends StatelessWidget {
  final TextEditingController nameC,
      phoneC,
      countryC,
      cityC,
      stateC,
      latC,
      longC;
  final GlobalKey<FormState> formKey;

  const AddressFormFields({
    super.key,
    required this.formKey,
    required this.nameC,
    required this.phoneC,
    required this.countryC,
    required this.cityC,
    required this.stateC,
    required this.latC,
    required this.longC,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomeTextFieldWithSvgPictureWidget(
            keyboardType: TextInputType.text,
            controller: nameC,
            imagePath: TImages.name,
            label: AddressConstant.addressFormName.tr(context),
            validator: TValidator.validateField,
          ),
          const SizedBox(height: TSizes.spaceBtnItems),
          CustomeTextFieldWithSvgPictureWidget(
            keyboardType: TextInputType.text,
            controller: phoneC,
            imagePath: TImages.phone,
            label: AddressConstant.addressFormPhone.tr(context),
            validator: TValidator.validateField,
          ),
          const SizedBox(height: TSizes.spaceBtnItems),
          CustomeTextFieldWithSvgPictureWidget(
            keyboardType: TextInputType.text,
            controller: countryC,
            imagePath: TImages.country,
            label: AddressConstant.addressFormCountry.tr(context),
            validator: TValidator.validateField,
          ),
          const SizedBox(height: TSizes.spaceBtnItems),
          Row(
            children: [
              Expanded(
                child: CustomeTextFieldWithSvgPictureWidget(
                  keyboardType: TextInputType.text,
                  controller: cityC,
                  imagePath: TImages.city,
                  label: AddressConstant.addressFormCity.tr(context),
                  validator: TValidator.validateField,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtnItems),
              Expanded(
                child: CustomeTextFieldWithSvgPictureWidget(
                  keyboardType: TextInputType.text,
                  controller: stateC,
                  imagePath: TImages.state,
                  label: AddressConstant.addressFormState.tr(context),
                  validator: TValidator.validateField,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtnItems),
          Row(
            children: [
              Expanded(
                child: CustomeTextFieldWithSvgPictureWidget(
                  keyboardType: TextInputType.text,
                  controller: latC,
                  imagePath: TImages.latLong,
                  label: AddressConstant.addressFormLatitude.tr(context),
                  validator: TValidator.validateField,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtnItems),
              Expanded(
                child: CustomeTextFieldWithSvgPictureWidget(
                  keyboardType: TextInputType.text,
                  controller: longC,
                  imagePath: TImages.latLong,
                  label: AddressConstant.addressFormLongitude.tr(context),
                  validator: TValidator.validateField,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
