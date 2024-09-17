import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/constants/strings.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:cars_equipments_shop/core/shared/data/local/shared_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/functions/helper_functions.dart';
import '../../data/models/shop_model.dart';
import '../bloc/add_delete_edit_shop/add_edit_delete_shop_bloc.dart';
import 'single_workshop_widget.dart';

class ShopList extends StatefulWidget {
  final List<ShopModel> shops;
  const ShopList({super.key, required this.shops});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditDeleteShopBloc, AddEditDeleteShopState>(
      listener: (context, state) {
        if (state is DeleteShopErrorState) {
          THelperFunctions.showSnackBar(
            context: context,
            message: state.errorMsg,
            title: SharedConstants.messageWrongAlertTitle.tr(context),
            type: ContentType.failure,
          );
        } else if (state is DeleteShopLoadedState) {
          THelperFunctions.showSnackBar(
            context: context,
            message: SharedConstants.sharedDeleteSuccessfully.tr(context),
            title: SharedConstants.messageSuccessAlertTitle.tr(context),
            type: ContentType.success,
          );
          for (var element in List.from(widget.shops!)) {
            if (element.dateAdded == state.productId) {
              setState(() {
                widget.shops.remove(element);
              });
            }
          }
        }
      },
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.shops.length,
          itemBuilder: (context, index) => SingleWorkshopWidget(
            shop: widget.shops[index],
            margin:
                index == (widget.shops.length - 1) ? 0.0 : TSizes.spaceBtnItems,
          ),
        );
      },
    );
  }
}
