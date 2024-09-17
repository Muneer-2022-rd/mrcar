part of 'shop_bloc.dart';

abstract class ShopState {}

class MaintenanceInitial extends ShopState {}

class ShopsLoading extends ShopState {}

class ShopsLoaded extends ShopState {
  final List<ShopModel>? allShops;
  ShopsLoaded({
    required this.allShops,
  });
}

class ShopsError extends ShopState {
  final String errorMsg;
  ShopsError({required this.errorMsg});
}
