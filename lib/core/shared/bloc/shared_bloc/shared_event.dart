part of 'shared_bloc.dart';

abstract class SharedEvent extends Equatable {
  const SharedEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends SharedEvent {
  final String? collection;
   File? image;
  final String? fieldChanged;
   UploadImageEvent({
    required this.collection,
    required this.image,
    required this.fieldChanged,
  });
  @override
  List<Object> get props => [
        collection as String,
        image as File,
        fieldChanged as String,
      ];
}
