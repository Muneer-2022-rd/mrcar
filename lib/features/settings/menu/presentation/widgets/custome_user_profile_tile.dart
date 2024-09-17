import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/shared/widgets/custome_circular_image.dart';
import '../../../../../core/shared/widgets/custome_shimmer_effect.dart';

class CustomeUserProfileTile extends StatelessWidget {
  const CustomeUserProfileTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.icon,
    this.onPressed,
  });
  final String title;
  final String subTitle;
  final String imagePath;
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imagePath.isNotEmpty && imagePath != ""
          ? CustomeCircularImage(
              isNetworkImage: true,
              imagePath: imagePath,
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(0),
            )
          : const CustomeShimmerEffect(width: 50, height: 50),
      title: title.isNotEmpty && title != ""
          ? Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
            )
          : const CustomeShimmerEffect(width: 25, height: 5),
      subtitle: subTitle.isNotEmpty && subTitle != ""
          ? Text(
              subTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: TColors.white),
            )
          : const CustomeShimmerEffect(width: 100, height: 10),
      trailing: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
