import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../../core/shared/widgets/custome_loading.dart';
import '../../../register/data/local/register_local.dart';
import '../../data/local/profile_local.dart';
import '../blocs/profile_oberations_bloc/edit_bloc.dart';

class EditGender extends StatefulWidget {
  const EditGender({
    super.key,
    required this.gender,
    required this.onGenderUpdated,
  });
  final String? gender;
  final Function(String) onGenderUpdated;

  @override
  State<EditGender> createState() => _EditGenderState();
}

class _EditGenderState extends State<EditGender> {
  String? userGender;

  @override
  void initState() {
    super.initState();
    userGender = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          "Change Gender",
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
            widget.onGenderUpdated(userGender!);
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
                        "Choose Gender, it helps you with you search",
                      ),
                      const SizedBox(height: TSizes.spaceBtnSections),
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
                                RegisterConstants.registerFormGender
                                    .tr(context),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
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
                                            .copyWith(
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          value: userGender!.isEmpty
                              ? RegisterConstants.genders.first.gender
                              : userGender,
                          onChanged: (value) {
                            setState(() {
                              userGender = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtnSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<ProfileOperationsBloc>(context).add(
                              UpdateSingleFieldEvent(newValue: {
                                "user_gendar": userGender,
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
