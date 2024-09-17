import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../features/address/presentation/blocs/address_operations_bloc/address_operations_bloc.dart';
import '../../features/address/presentation/blocs/my_addresses_bloc/my_addresses_bloc.dart';
import '../../features/address/presentation/pages/add_address_page.dart';
import '../../features/address/presentation/pages/my_address_page.dart';
import '../../features/auth/login/presentation/bloc/login_bloc.dart';
import '../../features/auth/login/presentation/pages/login_page.dart';
import '../../features/auth/profile/presentation/blocs/my_profile_bloc/profile_bloc.dart';
import '../../features/auth/profile/presentation/blocs/profile_oberations_bloc/edit_bloc.dart';
import '../../features/auth/register/presentation/bloc/register_bloc.dart';
import '../../features/auth/register/presentation/pages/register_success_screen.dart';
import '../../features/navigation_bar/presentation/cubit/navigation_menu_cubit.dart';
import '../../features/navigation_bar/presentation/pages/navigation_menu.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/settings/lang/data/localization.dart';
import '../../features/settings/menu/bloc/menu_bloc.dart';
import '../../features/settings/menu/presentation/cubit/settings_cubit.dart';
import '../../features/settings/menu/presentation/screens/settings_screen.dart';
import '../../features/settings/theme/bloc/theme_bloc.dart';
import '../../features/workshop/presentation/bloc/add_delete_edit_shop/add_edit_delete_shop_bloc.dart';
import '../../features/workshop/presentation/bloc/my_shops_bloc/my_shops_bloc.dart';
import '../../features/workshop/presentation/bloc/shop_bloc/shop_bloc.dart';
import '../../features/workshop/presentation/pages/my_shops_page.dart';
import '../../features/workshop/presentation/pages/shops_page.dart';
import 'bloc_observer.dart';
import 'core/shared/bloc/select_home/select_home_bloc.dart';
import 'core/shared/bloc/shared_bloc/shared_bloc.dart';
import 'core/shared/data/local/shared_local.dart';
import 'features/auth/login/presentation/pages/login_by_phone_page.dart';
import 'features/auth/profile/presentation/pages/profile_page.dart';
import 'features/auth/register/presentation/pages/register_screen.dart';
import 'features/settings/lang/cubit/locale_cubit.dart';
import 'features/workshop/presentation/pages/add_shop_page.dart';
import 'get_it_import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // select home page
        BlocProvider<SelectHomeBloc>(
          create: (_) => getIt<SelectHomeBloc>()
            ..add(const UpdateSelectedHomeEvent(selectPage: OnBoardingPage())),
        ),
        // theme
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>()..add(GetCurrentThemeEvent()),
        ),
        // lang
        BlocProvider<LocaleCubit>(
          create: (_) => getIt<LocaleCubit>()..getSavedLanguage(),
        ),
        // shared
        BlocProvider<SharedBloc>(
          create: (_) => getIt<SharedBloc>(),
        ),
        // register
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        // login
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        // navigation_menu
        BlocProvider<NavigationMenuCubit>(
          create: (_) => getIt<NavigationMenuCubit>()
            ..currentPageIndexEvent(selectedPage: 0),
        ),
        // settings
        BlocProvider<SettingsCubit>(
          create: (_) => getIt<SettingsCubit>(),
        ),
        BlocProvider<MenuBloc>(
          create: (_) => getIt<MenuBloc>()..add(FetchUserSettingsDataEvent()),
        ),
        // profile and profile operations
        BlocProvider<ProfileBloc>(
          create: (_) => getIt<ProfileBloc>()..add(FetchUserDataEvent()),
        ),
        BlocProvider<ProfileOperationsBloc>(
          create: (_) => getIt<ProfileOperationsBloc>(),
        ),
        // addresses and address operations
        BlocProvider<MyAddressesBloc>(
          create: (_) => getIt<MyAddressesBloc>()..add(GetMyAddressesEvent()),
        ),
        BlocProvider<AddressOperationsBloc>(
          create: (_) => getIt<AddressOperationsBloc>(),
        ),
        // shops, myshops and shops operation
        BlocProvider<ShopBloc>(
            create: (_) => getIt<ShopBloc>()
              ..add(
                LoadShopsDataEvent(),
              )),
        BlocProvider<MyShopsBloc>(
          create: (_) => getIt<MyShopsBloc>()..add(LoadMyShopsDataEvent()),
        ),
        BlocProvider<AddEditDeleteShopBloc>(
          create: (_) => getIt<AddEditDeleteShopBloc>(),
        ),
      ],
      child: BlocBuilder<SelectHomeBloc, SelectHomeState>(
        builder: (context, state) {
          if (state is UpdateSelectedHomeState) {
            final selectPage = state.selectPage;
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                if (state is LoadedThemeState) {
                  final theme = state.themeData;
                  return BlocBuilder<LocaleCubit, ChangeLocaleState>(
                    builder: (context, state) {
                      return MaterialApp(
                        theme: theme.copyWith(
                            textTheme: theme.textTheme.apply(
                                fontFamily: state.locale.languageCode == 'ar'
                                    ? 'Fustat'
                                    : 'Poppins')),
                        locale: state.locale,
                        supportedLocales: const [Locale('en'), Locale('ar')],
                        localizationsDelegates: const [
                          AppLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate
                        ],
                        localeResolutionCallback:
                            (deviceLocale, supportedLocales) {
                          for (var locale in supportedLocales) {
                            if (deviceLocale != null &&
                                deviceLocale.languageCode ==
                                    locale.languageCode) {
                              return deviceLocale;
                            }
                          }
                          return supportedLocales.first;
                        },
                        debugShowCheckedModeBanner: false,
                        debugShowMaterialGrid: false,
                        title: 'Flutter Demo',
                        initialRoute: PagesName.homePage,
                        routes: {
                          PagesName.homePage: (context) => selectPage,
                          PagesName.loginPage: (context) => const LoginPage(),
                          PagesName.registerPage: (context) =>
                              const RegisterScreen(),
                          PagesName.onboardingPage: (context) =>
                              const OnBoardingPage(),
                          PagesName.profilePage: (context) =>
                              const ProfilePage(),
                          PagesName.navigationMenuPage: (context) =>
                              const NavigationMenu(),
                          PagesName.settingsPage: (context) =>
                              const SettingsPage(),
                          PagesName.addressPage: (context) =>
                              const AddressScreen(),
                          PagesName.addAddressPage: (context) =>
                              const AddAddressPage(),
                          PagesName.registerSuccessPage: (context) =>
                              const RegisterSuccessScreen(),
                          PagesName.shopAdd: (context) => const AddShopPage(),
                          PagesName.shops: (context) => const ShopsPage(),
                          PagesName.myShops: (context) => const MyShopsPage(),
                          PagesName.byPhone: (context) => const LoginByPhonePage(),
                        },
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
