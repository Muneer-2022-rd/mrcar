part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {
  final String email;
  const RegisterSuccessState({required this.email});
  @override
  List<Object> get props => [email];
}

final class RegisterErrorState extends RegisterState {
  final String errorMsg;
  const RegisterErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class CheckValidationLoadingState extends RegisterState {}

final class CheckValidationSuccessState extends RegisterState {}

final class CheckValidationErrorState extends RegisterState {
  final String errorMsg;
  const CheckValidationErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class NoInternetConnectionState extends RegisterState {}
