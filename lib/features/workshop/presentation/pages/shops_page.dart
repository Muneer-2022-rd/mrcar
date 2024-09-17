import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../core/shared/widgets/search_container.dart';
import '../bloc/my_shops_bloc/my_shops_bloc.dart';
import '../bloc/shop_bloc/shop_bloc.dart';
import '../widgets/listview_shimmer_layout_shops.dart';
import '../widgets/shops_list_view.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({super.key});

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          'Workshops',
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
                child: BlocConsumer<ShopBloc, ShopState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is ShopsLoading) {
                      return const ListViewShimmerLayoutShops(
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        width: double.infinity,
                      );
                    } else if (state is ShopsLoaded) {
                      final shops = state.allShops;
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
