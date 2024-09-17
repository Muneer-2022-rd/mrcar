part of 'images_bloc.dart';

abstract class ImagesState {}

class ImagesInitial extends ImagesState {}

class DeleteImageLoadingState extends ImagesState {}

class DeleteImageSuccessState extends ImagesState {
  final String deletedImageUrl;
  DeleteImageSuccessState({required this.deletedImageUrl});
}

class DeleteImageFauilerState extends ImagesState {
  final String errorMsg;
  DeleteImageFauilerState({required this.errorMsg});
}
