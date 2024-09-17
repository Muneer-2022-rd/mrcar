import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/shared/data/local/shared_local.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/helper_functions.dart';
import '../../blocs/address_operations_bloc/address_operations_bloc.dart';
import '../../blocs/my_addresses_bloc/my_addresses_bloc.dart';

class AddressSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function onSubmit;

  const AddressSubmitButton({
    super.key,
    required this.formKey,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressOperationsBloc, AddressOperationsBlocState>(
      listener: (context, state) {
        if (state is AddAddressLoadedState) {
          THelperFunctions.showSnackBar(
            context: context,
            message: SharedConstants.sharedAddedSuccessfully.tr(context),
            title: SharedConstants.messageSuccessAlertTitle.tr(context),
            type: ContentType.success,
          );
          Navigator.of(context).pop();
          context.read<MyAddressesBloc>().add(GetMyAddressesEvent());
        } else if (state is AddAddressErrorState) {
          THelperFunctions.showSnackBar(
            context: context,
            message: state.errorMsg,
            title: SharedConstants.messageWrongAlertTitle.tr(context),
            type: ContentType.failure,
          );
        } else if (state is AddressOperationsNoInternetConnectionState) {
          THelperFunctions.showSnackBar(
            context: context,
            title: SharedConstants.messageWrongAlertTitle.tr(context),
            message: SharedConstants.messageNoInternetConnection.tr(context),
            type: ContentType.failure,
          );
        }
      },
      builder: (context, state) {
        return state is AddAddressLoadingState
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    onSubmit();
                  }
                },
                child: Text(SharedConstants.sharedSubmit.tr(context)),
              );
      },
    );
  }
}
