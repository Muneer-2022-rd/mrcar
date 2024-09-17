part of 'edit_bloc.dart';

abstract class ProfileOperationsBlocState extends Equatable {
  const ProfileOperationsBlocState();

  @override
  List<Object> get props => [];
}

class EditInitial extends ProfileOperationsBlocState {}

final class UpdateValueLoadingState extends ProfileOperationsBlocState {}

final class UpdateValueSuccessState extends ProfileOperationsBlocState {
   final Map<String, dynamic> newValue;
   const UpdateValueSuccessState({required this.newValue});
}

final class UpdateValueErrorState extends ProfileOperationsBlocState {
  final String errorMsg;
  const UpdateValueErrorState({required this.errorMsg});
}

final class EditProfileBlocNoInternetConnectionState extends ProfileOperationsBlocState {}