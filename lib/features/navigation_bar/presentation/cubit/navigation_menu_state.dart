part of 'navigation_menu_cubit.dart';

abstract class NavigationMenuState extends Equatable {
  const NavigationMenuState();

  @override
  List<Object> get props => [];
}

class NavigationMenuInitial extends NavigationMenuState {}

final class CurrentPageIndexState extends NavigationMenuState {
   int currentPage;
   CurrentPageIndexState({required this.currentPage});
   @override
  List<Object> get props => [currentPage];
}
