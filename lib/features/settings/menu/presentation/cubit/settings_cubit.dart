import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  bool notify = false;
  final FirebaseMessaging firebaseMessaging;
  final FirebaseAuth auth;
  final SharedPreferences sharedPreferences;
  SettingsCubit({
    required this.firebaseMessaging,
    required this.sharedPreferences,
    required this.auth,
  }) : super(SettingsInitial());

  Future<void> getPreferncessNotification() async {
    notify = sharedPreferences.getBool('notify') ?? false;
    emit(GetPreferncessNotificationState());
  }

  bool userIsLogedIn() {
    final user = auth.currentUser;
    if (user == null) {
      emit(UserIsNotLogedInState());
      return false;
    } else {
      if (user.emailVerified == true) {
        return true;
      } else {
        emit(UserIsNotLogedInState());
        return false;
      }
    }
  }

  Future<void> requestNotificationPermission(bool value) async {
    final PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      if (value) {
        notify = value;
        sharedPreferences.setBool("notify", notify);
        await firebaseMessaging.subscribeToTopic("adverts");
      } else {
        notify = value;
        sharedPreferences.setBool("notify", notify);
        await firebaseMessaging.unsubscribeFromTopic("adverts");
      }
    } else if (status.isDenied) {
      notify = false;
      sharedPreferences.setBool("notify", notify);
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      notify = false;
      sharedPreferences.setBool("notify", notify);
    } else {
      notify = false;
      sharedPreferences.setBool("notify", notify);
    }
    emit(ToggleNotificationsState());
  }
}
