part of 'edit_bloc.dart';

abstract class ProfileOperationsBlocEvent extends Equatable {
  const ProfileOperationsBlocEvent();

  @override
  List<Object> get props => [];
}

class UpdateSingleFieldEvent extends ProfileOperationsBlocEvent {
  final Map<String, dynamic> newValue;

  const UpdateSingleFieldEvent({
    required this.newValue
  });

  @override
  List<Object> get props => [newValue];
}