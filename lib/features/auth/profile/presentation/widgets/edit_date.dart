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
import '../../data/local/profile_local.dart';
import '../blocs/profile_oberations_bloc/edit_bloc.dart';
import '../blocs/my_profile_bloc/profile_bloc.dart';

class EditDate extends StatefulWidget {
  const EditDate(
      {super.key, required this.date, required this.onBirthDateUpdated});
  final String date;
  final Function(String) onBirthDateUpdated;
  @override
  State<EditDate> createState() => _EditDateState();
}

class _EditDateState extends State<EditDate> {
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    selectedDate =
        widget.date.isEmpty ? DateTime.now() : DateTime.parse(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          "Change Date",
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
            widget.onBirthDateUpdated(
                THelperFunctions.getFormattedDate(selectedDate!));
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
                        "Choose Date For Easy Verifiaction.",
                      ),
                      const SizedBox(height: TSizes.spaceBtnSections),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate ?? DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null && picked != selectedDate) {
                                  setState(() {
                                    selectedDate = picked;
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Iconsax.calendar_1,
                                    color: TColors.grey,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    selectedDate == null
                                        ? 'date of birth'
                                        : THelperFunctions.getFormattedDate(
                                            selectedDate!),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtnSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<ProfileOperationsBloc>(context).add(
                              UpdateSingleFieldEvent(newValue: {
                                "user_date_birth":
                                    THelperFunctions.getFormattedDate(
                                        selectedDate!),
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
