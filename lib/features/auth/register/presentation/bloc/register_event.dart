part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends RegisterEvent {
  final String userName;
  final String userFirst;
  final String userLast;
  final String userEmail;
  final PhoneNumberModel userPhone;
  final String userGender;
  final String userDateBirth;
  final String password;
  final File? userImageProfile;
  const SignUpEvent({
    required this.userName,
    required this.userFirst,
    required this.userLast,
    required this.userEmail,
    required this.userPhone,
    required this.userGender,
    required this.userDateBirth,
    required this.password,
     this.userImageProfile,
  });

  @override
  List<Object> get props => [
        userName,
        userFirst,
        userLast,
        userEmail,
        userPhone,
        userGender,
        userDateBirth,
        password,
        
      ];
}

class CheckEmailValidationEvent extends RegisterEvent {}

class ResendEmailValidationEvent extends RegisterEvent {}
