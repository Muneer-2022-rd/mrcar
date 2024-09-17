part of 'settings_cubit.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class GetPreferncessNotificationState extends SettingsState {}

final class ToggleNotificationsState extends SettingsState {}

final class UserIsNotLogedInState extends SettingsState {}