part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserDataEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}
