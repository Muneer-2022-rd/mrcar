part of 'get_it_import.dart';

GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
  // firebase
  await initFirebase();
  // cache
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  // select home page
  initSelectHomePage();
  // theme
  initTheme();
  // lang
  initLang();
  // network
  initNetwork();
  // shared
  initShared();
  // register
  initRegister();
  // login
  initLogin();
  // navigation_menu
  initNavigationMenu();
  // settings
  initSettings();
  // profile
  initProfile();
  // address
  initAddress();
  // shops
  initShops();
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    // appleProvider: AppleProvider.appAttest,
  );
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  getIt.registerLazySingleton<FirebaseStorage>(
    () => FirebaseStorage.instance,
  );
  getIt.registerLazySingleton<FirebaseMessaging>(
    () => FirebaseMessaging.instance,
  );
}

void initSelectHomePage() {
  getIt.registerFactory<SelectHomeBloc>(
      () => SelectHomeBloc(sharedPreferences: getIt<SharedPreferences>()));
}

void initTheme() {
  getIt.registerLazySingleton<ThemeCacheHelper>(
    () => ThemeCacheHelper(sharedPreferences: getIt<SharedPreferences>()),
  );
  getIt.registerFactory<ThemeBloc>(
      () => ThemeBloc(themeCacheHelper: getIt<ThemeCacheHelper>()));
}

void initLang() {
  getIt.registerLazySingleton<LanguageCacheHelper>(
    () => LanguageCacheHelper(sharedPreferences: getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(languageCacheHelper: getIt<LanguageCacheHelper>()),
  );
}

void initNetwork() {
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: InternetConnectionChecker(),
    ),
  );
}

void initShared() {
  getIt.registerLazySingleton<SharedRepository>(
    () => SharedRepository(
      storage: getIt<FirebaseStorage>(),
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<SharedBloc>(
    () => SharedBloc(
      auth: getIt<FirebaseAuth>(),
      sharedRepository: getIt<SharedRepository>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
}

void initRegister() {
  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepository(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<RegisterBloc>(
    () => RegisterBloc(
      registerRepository: getIt<RegisterRepository>(),
      networkInfo: getIt<NetworkInfo>(),
      auth: getIt<FirebaseAuth>(),
      sharedRepository: getIt<SharedRepository>(),
    ),
  );
}

void initLogin() {
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepository(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc(
        loginRepository: getIt<LoginRepository>(),
        networkInfo: getIt<NetworkInfo>(),
        registerRepository: getIt<RegisterRepository>(),
        sharedPreferences: getIt<SharedPreferences>(),
        auth: getIt<FirebaseAuth>(),
      ));
}

void initNavigationMenu() {
  getIt.registerLazySingleton<NavigationMenuCubit>(
    () => NavigationMenuCubit(),
  );
}

void initSettings() {
  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(
      firebaseMessaging: getIt<FirebaseMessaging>(),
      sharedPreferences: getIt<SharedPreferences>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<MenuRepository>(
    () => MenuRepository(
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<MenuBloc>(
    () => MenuBloc(
      menuRepository: getIt<MenuRepository>(),
      networkInfo: getIt<NetworkInfo>(),
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );
}

void initProfile() {
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      storage: getIt<FirebaseStorage>(),
    ),
  );
  getIt.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(
      profileRepository: getIt<ProfileRepository>(),
      networkInfo: getIt<NetworkInfo>(),
      sharedPreferences: getIt<SharedPreferences>(), auth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<ProfileOperationsBloc>(
    () => ProfileOperationsBloc(
      profileRepository: getIt<ProfileRepository>(),
      networkInfo: getIt<NetworkInfo>(),
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );
}

void initAddress() {
  getIt.registerLazySingleton<AddressRepository>(
    () => AddressRepository(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<MyAddressesBloc>(
    () => MyAddressesBloc(
      addressRepository: getIt<AddressRepository>(),
      networkInfo: getIt<NetworkInfo>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<AddressOperationsBloc>(
    () => AddressOperationsBloc(
      addressRepository: getIt<AddressRepository>(),
      auth: getIt<FirebaseAuth>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
}

void initShops() {
  getIt.registerLazySingleton<ShopsRepository>(
    () => ShopsRepository(
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<ShopBloc>(
    () => ShopBloc(
      shopsRepository: getIt<ShopsRepository>(),
    ),
  );
  getIt.registerLazySingleton<MyShopsBloc>(
    () => MyShopsBloc(
      shopsRepository: getIt<ShopsRepository>(),
    ),
  );
  getIt.registerLazySingleton<AddEditDeleteShopsRepository>(
    () => AddEditDeleteShopsRepository(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<AddEditDeleteShopBloc>(
    () => AddEditDeleteShopBloc(
      addEditDeleteShopsRepository: getIt<AddEditDeleteShopsRepository>(),
      auth: getIt<FirebaseAuth>(),
      addressRepository: getIt<AddressRepository>(),
      sharedRepository: getIt<SharedRepository>(),
    ),
  );
}
