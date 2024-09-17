import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/shop_model.dart';
import '../../../data/remote/shops_data.dart';

part 'my_shops_event.dart';
part 'my_shops_state.dart';

class MyShopsBloc extends Bloc<MyShopsEvent, MyShopsState> {
  final ShopsRepository shopsRepository;
  MyShopsBloc({required this.shopsRepository}) : super(MyShopsInitial()) {
    on<MyShopsEvent>((event, emit) {});
    on<LoadMyShopsDataEvent>((event, emit) async {
      try {
        emit(MyShopsLoading());
        List<ShopModel>? myShops = await shopsRepository.getMyShops();
        emit(MyShopsLoaded(myShops: myShops));
      } catch (e) {
        emit(MyShopsError(errorMsg: e.toString()));
      }
    });
  }
}
