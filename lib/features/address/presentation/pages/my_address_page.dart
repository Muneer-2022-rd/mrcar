import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/functions/helper_functions.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/shared/data/local/shared_local.dart';
import '../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../core/shared/widgets/no_data_widget.dart';
import '../../data/local/address_local.dart';
import '../blocs/address_operations_bloc/address_operations_bloc.dart';
import '../blocs/my_addresses_bloc/my_addresses_bloc.dart';
import '../widgets/custome_single_address.dart';
import '../widgets/update_address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
        onPressed: () => pushNamed(context, PagesName.addAddressPage),
      ),
      appBar: CustomeAppBar(
        showBackArrow: true,
        title: Text(
          AddressConstant.addressesMyTitle.tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            context.read<MyAddressesBloc>()..add(GetMyAddressesEvent()),
        child: BlocConsumer<AddressOperationsBloc, AddressOperationsBlocState>(
          listener: (context, state) {
            if (state is UpdateAddressStateSuccess) {
              THelperFunctions.showSnackBar(
                context: context,
                message: SharedConstants.sharedUpdateSuccessfully.tr(context),
                title: SharedConstants.messageWrongAlertTitle,
                type: ContentType.success,
              );
            } else if (state is UpdateAddressStateError) {
              THelperFunctions.showSnackBar(
                context: context,
                message: state.errorMsg,
                title: SharedConstants.messageWrongAlertTitle,
                type: ContentType.failure,
              );
            } else if (state is DeleteAddressStateSuccess) {
              THelperFunctions.showSnackBar(
                context: context,
                message: SharedConstants.sharedDeleteSuccessfully.tr(context),
                title: SharedConstants.messageWrongAlertTitle,
                type: ContentType.success,
              );
            } else if (state is DeleteAddressStateError) {
              THelperFunctions.showSnackBar(
                context: context,
                message: state.errorMsg,
                title: SharedConstants.messageWrongAlertTitle,
                type: ContentType.failure,
              );
            }
          },
          builder: (context, state) {
            return BlocConsumer<MyAddressesBloc, MyAddressesState>(
              listener: (context, state) {
                if (state is MyAddressesErrorState) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    message: state.errorMsg,
                    title: SharedConstants.messageWrongAlertTitle,
                    type: ContentType.failure,
                  );
                } else if (state is MyAddressesNoInternetConnectionState) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    title: SharedConstants.messageWrongAlertTitle.tr(context),
                    message:
                        SharedConstants.messageNoInternetConnection.tr(context),
                    type: ContentType.failure,
                  );
                }
              },
              builder: (context, state) {
                if (state is MyAddressesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MyAddressesLoadedState) {
                  final addresses = state.addresses;
                  if (addresses.isEmpty) {
                    return NoDataWidget(
                        title: AddressConstant.addressesTitle.tr(context));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                return CustomeSingleAddress(
                                  addressModel: addresses[index],
                                  onTapDelete: () {
                                    context.read<AddressOperationsBloc>().add(
                                          DeleteExistAddressEvent(
                                            addressId: addresses[index].id,
                                          ),
                                        );
                                    setState(() {
                                      addresses.removeAt(index);
                                    });
                                  },
                                  onTapUpdate: () {
                                    showBottomSheet(
                                      builder: (context) {
                                        return const UpdateAddressWidget();
                                      },
                                      context: context,
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
