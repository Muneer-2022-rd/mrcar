import 'package:cars_equipments_shop/core/functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/shared/data/local/shared_local.dart';
import '../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../core/shared/widgets/search_container.dart';
import '../bloc/my_shops_bloc/my_shops_bloc.dart';
import '../bloc/shop_bloc/shop_bloc.dart';
import '../widgets/listview_shimmer_layout_shops.dart';
import '../widgets/shops_list_view.dart';

class MyShopsPage extends StatefulWidget {
  const MyShopsPage({super.key});

  @override
  State<MyShopsPage> createState() => _MyShopsPageState();
}

class _MyShopsPageState extends State<MyShopsPage> {
  @override
  void initState() {
    context.read<MyShopsBloc>().add(LoadMyShopsDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Iconsax.add,
            color: TColors.white,
          ),
          onPressed: () => pushNamed(context, PagesName.shopAdd)),
      appBar: CustomeAppBar(
        showBackArrow: true,
        title: Text(
          'My Workshops',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: TSizes.spaceBtnItems),
              const SearchContainer(
                title: "Search",
                padding: EdgeInsets.zero,
                collection: 'shop',
              ),
              const SizedBox(height: TSizes.spaceBtnSections),
              RefreshIndicator(
                onRefresh: () async {
                  context.read<MyShopsBloc>().add(
                        LoadMyShopsDataEvent(),
                      );
                },
                child: BlocConsumer<MyShopsBloc, MyShopsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ShopsLoading) {
                      return const ListViewShimmerLayoutShops(
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        width: double.infinity,
                      );
                    } else if (state is MyShopsLoaded) {
                      final shops = state.myShops;
                      return shops!.isNotEmpty
                          ? ShopList(shops: shops)
                          : const Center(child: Text('No Shops Available'));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
