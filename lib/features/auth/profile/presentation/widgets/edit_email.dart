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

class EditEmail extends StatefulWidget {
  const EditEmail({
    super.key,
    required this.email,
    required this.onEmailUpdated,
  });
  final String email;
  final Function(String) onEmailUpdated;

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  late TextEditingController emailC;
  @override
  void initState() {
    super.initState();
    emailC = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          ProfileConstants.profileUserEmail.tr(context),
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
            widget.onEmailUpdated(emailC.text.trim());
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
                            ProfileConstants.profileUserEmail.tr(context),
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.text,
                        controller: emailC,
                        validator: (value) => TValidator.validateEmail(value),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<ProfileOperationsBloc>(context).add(
                              UpdateSingleFieldEvent(newValue: {
                                "user_email": emailC.text.trim(),
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
