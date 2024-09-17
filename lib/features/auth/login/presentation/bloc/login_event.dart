part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class SignInEvent extends LoginEvent {
  final String email;
  final String password;
  const SignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class GoogleSignInEvent extends LoginEvent {}

class PhoneSignInEvent extends LoginEvent {
  final String id;
  final String otp;
  final String phoneNmuber;
  final String dialCode;
  const PhoneSignInEvent({
    required this.id,
    required this.otp,
    required this.phoneNmuber,
    required this.dialCode,
  });

  @override
  List<Object> get props => [id, otp];
}
