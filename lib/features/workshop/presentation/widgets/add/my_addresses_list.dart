import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../address/data/model/address_model.dart';
import '../../bloc/add_delete_edit_shop/add_edit_delete_shop_bloc.dart';
import 'single_selection_address.dart';

class MyAddressesList extends StatefulWidget {
  AddressModel address;
  final void Function(AddressModel) onAddressSelected;

  MyAddressesList({
    super.key,
    required this.address,
    required this.onAddressSelected,
  });

  @override
  State<MyAddressesList> createState() => _MyAddressesListState();
}

class _MyAddressesListState extends State<MyAddressesList> {
  AddressModel? selectedAddress;

  @override
  void initState() {
    selectedAddress = widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditDeleteShopBloc, AddEditDeleteShopState>(
      builder: (context, state) {
        if (state is MyAddressesInShopLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyAddressesInShopLoadedState) {
          final addresses = state.addresses;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Addresses',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(fontSizeDelta: 8),
              ),
              const SizedBox(height: TSizes.spaceBtnItems),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return TSingleSelectionAddress(
                    addressModel: addresses[index],
                    containerColor: selectedAddress == addresses[index]
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedAddress = addresses[index];
                        widget.onAddressSelected(selectedAddress!);
                      });
                    },
                    textColor: selectedAddress == addresses[index]
                        ? Colors.white
                        : Colors.black,
                  );
                },
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
