part of 'my_shops_bloc.dart';

abstract class MyShopsState {}

class MyShopsInitial extends MyShopsState {}

class MyShopsLoading extends MyShopsState {}

class MyShopsLoaded extends MyShopsState {
  final List<ShopModel>? myShops;
  MyShopsLoaded({
    required this.myShops,
  });
}

class MyShopsError extends MyShopsState {
  final String errorMsg;
  MyShopsError({required this.errorMsg});
}
