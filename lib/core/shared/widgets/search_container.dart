
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../functions/helper_functions.dart';
class SearchContainer extends StatefulWidget {
  const SearchContainer({
    super.key,
    required this.title,
    this.iconData = Iconsax.search_normal,
    this.showBackground = true,
    this.showBoarder = true,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
    required this.collection,
  });

  final String title;
  final String collection;
  final IconData? iconData;
  final bool showBackground, showBoarder;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        // push(
        //   context,
        //   SearchPage(
        //     collection: widget.collection,
        //   ),
        // );
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(left: TSizes.md),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.showBackground
              ? dark
                  ? TColors.dark
                  : TColors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: widget.showBoarder ? Border.all(color: TColors.grey) : null,
        ),
        child: Center(
          child: TextFormField(
            enabled: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: widget.title,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffixIcon: const Icon(Iconsax.search_normal),
            ),
          ),
        ),
      ),
    );
  }
}
