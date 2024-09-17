import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/images_data.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImagesRepository imagesRepository;
  ImagesBloc({required this.imagesRepository}) : super(ImagesInitial()) {
    on<ImagesEvent>((event, emit) {});
    on<DeleteImageEvent>((event, emit) async {
      try {
        emit(DeleteImageLoadingState());
         await imagesRepository.deleteSingleImage(
          collection: event.collection,
          productId: event.productId,
          imageUrl: event.imageUrl,
        );
        emit(DeleteImageSuccessState(deletedImageUrl: event.imageUrl));
      } catch (e) {
        emit(DeleteImageFauilerState(errorMsg: e.toString()));
      }
    });
  }
}