part of 'shared_bloc.dart';

abstract class SharedState extends Equatable {
  const SharedState();

  @override
  List<Object> get props => [];
}

class SharedInitial extends SharedState {}

class NoInternetConnectionState extends SharedState {}

class UploadImageSuccessState extends SharedState {
  File image;
  UploadImageSuccessState({required this.image});
}

class UploadImageErrorState extends SharedState {
  final String errorMsg;
  const UploadImageErrorState({required this.errorMsg});
}

class UploadImageLoadingState extends SharedState {}
