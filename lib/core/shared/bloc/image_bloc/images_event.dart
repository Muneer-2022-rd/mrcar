part of 'images_bloc.dart';

abstract class ImagesEvent {}

class DeleteImageEvent extends ImagesEvent {
  final String collection;
  final String productId;
  final String imageUrl;
  DeleteImageEvent({
    required this.collection,
    required this.productId,
    required this.imageUrl,
  });
}
