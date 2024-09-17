part of 'select_home_bloc.dart';

abstract class SelectHomeEvent extends Equatable {
  const SelectHomeEvent();

  @override
  List<Object> get props => [];
}
class UpdateSelectedHomeEvent extends SelectHomeEvent {
  final Widget selectPage;
  const UpdateSelectedHomeEvent({required this.selectPage});
    @override
  List<Object> get props => [selectPage];
}