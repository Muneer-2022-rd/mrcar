import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/shared/widgets/custome_loading.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../../core/shared/widgets/custome_text_form_field.dart';
import '../../../../../core/validation/validator.dart';
import '../../data/local/profile_local.dart';
import '../blocs/profile_oberations_bloc/edit_bloc.dart';

class EditName extends StatefulWidget {
  const EditName({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.onNameUpdated,
  });
  final String firstName;
  final String lastName;
  final Function(String, String) onNameUpdated;

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  late TextEditingController firstNameC;
  late TextEditingController lastNameC;
  @override
  void initState() {
    super.initState();
    firstNameC = TextEditingController(text: widget.firstName);
    lastNameC = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    firstNameC.dispose();
    lastNameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          ProfileConstants.profileEditNameTitle.tr(context),
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
            widget.onNameUpdated(firstNameC.text.trim(), lastNameC.text.trim());
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
                      Text(
                          ProfileConstants.profileEditNameSubTitle.tr(context)),
                      const SizedBox(height: TSizes.spaceBtnSections),
                      CustomeTextFormField(
                        labelText:
                            ProfileConstants.profileUserFirstName.tr(context),
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.text,
                        controller: firstNameC,
                        validator: (value) => TValidator.validateField(value),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      CustomeTextFormField(
                        labelText:
                            ProfileConstants.profileUserLastName.tr(context),
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.text,
                        controller: lastNameC,
                        validator: (value) => TValidator.validateField(value),
                      ),
                      const SizedBox(height: TSizes.spaceBtnSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<ProfileOperationsBloc>(context).add(
                              UpdateSingleFieldEvent(newValue: {
                                "user_first": firstNameC.text.trim(),
                                "user_last": lastNameC.text.trim(),
                              }),
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
                      ),
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
