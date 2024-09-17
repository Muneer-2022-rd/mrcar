part of 'select_home_bloc.dart';

abstract class SelectHomeState extends Equatable {
  const SelectHomeState();

  @override
  List<Object> get props => [];
}

class SelectHomeInitial extends SelectHomeState {}

class UpdateSelectedHomeState extends SelectHomeState {
  final Widget selectPage;
  const UpdateSelectedHomeState({required this.selectPage});
  @override
  List<Object> get props => [selectPage];
}
