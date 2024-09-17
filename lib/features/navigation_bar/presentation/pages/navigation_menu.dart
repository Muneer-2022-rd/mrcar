import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../settings/menu/presentation/screens/settings_screen.dart';
import '../../../workshop/presentation/pages/shops_page.dart';
import '../../data/local/navigation_menu_local.dart';
import '../cubit/navigation_menu_cubit.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  List<Widget> pagesList = [
    const SizedBox(),
    const SizedBox(),
    const ShopsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationMenuCubit, NavigationMenuState>(
      builder: (context, state) {
        if (state is CurrentPageIndexState) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: state.currentPage,
              onDestinationSelected: (value) {
                BlocProvider.of<NavigationMenuCubit>(context)
                    .currentPageIndexEvent(selectedPage: value);
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Iconsax.home),
                  label: NavigationMenuConstants.navigationMenuHome.tr(context),
                ),
                NavigationDestination(
                  icon: const Icon(Iconsax.shop),
                  label:
                      NavigationMenuConstants.navigationMenuStore.tr(context),
                ),
                NavigationDestination(
                  icon: const Icon(Iconsax.setting),
                  label:
                      NavigationMenuConstants.navigationMenuShops.tr(context),
                ),
                NavigationDestination(
                  icon: const Icon(Iconsax.user),
                  label: NavigationMenuConstants.navigationMenuSettings
                      .tr(context),
                ),
              ],
            ),
            body: pagesList[state.currentPage],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
