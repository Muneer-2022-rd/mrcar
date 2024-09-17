part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String errorMsg;
  const LoginErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class NoInternetConnectionState extends LoginState {}

final class GoogleLoginLoadingState extends LoginState {}

final class GoogleLoginSuccessState extends LoginState {}

final class GoogleLoginErrorState extends LoginState {
  final String errorMsg;
  const GoogleLoginErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class PhoneLoginLoadingState extends LoginState {}

final class PhoneLoginSuccessState extends LoginState {}

final class PhoneLoginErrorState extends LoginState {
  final String errorMsg;
  const PhoneLoginErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}