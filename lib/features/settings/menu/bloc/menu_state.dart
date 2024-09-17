part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class FetchUserSettingsDataSuccessState extends MenuState {
  final Map<String, dynamic> userData;
  const FetchUserSettingsDataSuccessState({required this.userData});
}

class FetchUserSettingsDataLoadingState extends MenuState {}

class FetchUserSettingsDataErrorState extends MenuState {
  final String errorMsg;
  const FetchUserSettingsDataErrorState({required this.errorMsg});
}

class FetchUserSettingsDataNoInternetConnection extends MenuState {
  final Map<String, dynamic> userData;
  const FetchUserSettingsDataNoInternetConnection({required this.userData});
}
