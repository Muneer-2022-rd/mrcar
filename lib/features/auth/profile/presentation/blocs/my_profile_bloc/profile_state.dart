part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class FetchUserDataSuccessState extends ProfileState {
  final UserModel userModel;
  const FetchUserDataSuccessState({required this.userModel});
}

class FetchUserDataLoadingState extends ProfileState {}

class FetchUserDataErrorState extends ProfileState {
  final String errorMsg;
  const FetchUserDataErrorState({required this.errorMsg});
}

class FetchUserDataNoInternetConnection extends ProfileState {
  final UserModel userModel;
  const FetchUserDataNoInternetConnection({required this.userModel});
}

class LogoutState extends ProfileState {}