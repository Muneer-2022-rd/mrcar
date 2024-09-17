import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/bloc/image_bloc/images_bloc.dart';
import '../../../data/models/shop_model.dart';
import 'single_image_from_old_images.dart';

class OldImagesList extends StatefulWidget {
  const OldImagesList({
    super.key,
    required this.oldImages,
    required this.shop,
  });
  final List<String>? oldImages;
  final ShopModel shop;
  @override
  State<OldImagesList> createState() => _OldImagesListState();
}

class _OldImagesListState extends State<OldImagesList> {
  @override
  Widget build(BuildContext context) {
    return widget.oldImages!.isNotEmpty
        ? Column(
            children: [
              Text(
                'Previous Images',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(fontSizeDelta: 8),
              ),
              const SizedBox(height: TSizes.spaceBtnItems),
              BlocBuilder<ImagesBloc, ImagesState>(
                builder: (context, state) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.oldImages!.length,
                    itemBuilder: (context, index) {
                      return SingleImage(
                        image: widget.oldImages![index],
                        onPressed: () {
                          context.read<ImagesBloc>().add(
                                DeleteImageEvent(
                                  collection: 'shops',
                                  productId: widget.shop.dateAdded!,
                                  imageUrl: widget.oldImages![index],
                                ),
                              );
                          widget.oldImages!.remove(widget.oldImages![index]);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
