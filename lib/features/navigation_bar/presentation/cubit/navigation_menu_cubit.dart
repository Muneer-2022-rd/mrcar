import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_menu_state.dart';

class NavigationMenuCubit extends Cubit<NavigationMenuState> {
  NavigationMenuCubit() : super(NavigationMenuInitial());
  currentPageIndexEvent({required int selectedPage}) {
    emit(CurrentPageIndexState(currentPage: selectedPage));
  }
}
