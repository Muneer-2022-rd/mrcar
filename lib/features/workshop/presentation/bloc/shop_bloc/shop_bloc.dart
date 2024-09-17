import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/shop_model.dart';
import '../../../data/remote/shops_data.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopsRepository shopsRepository;
  ShopBloc({required this.shopsRepository}) : super(MaintenanceInitial()) {
    on<ShopEvent>((event, emit) {});
    on<LoadShopsDataEvent>((event, emit) async {
      try {
        emit(ShopsLoading());
        List<ShopModel>? allShops = await shopsRepository.getAllShops();
        emit(ShopsLoaded(allShops: allShops));
      } catch (e) {
        emit(ShopsError(errorMsg: e.toString()));
      }
    });
  }
}
