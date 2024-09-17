import 'package:flutter/material.dart';

import '../../../../../core/shared/widgets/custome_shimmer_effect.dart';

class CustomeUserProfileTileShimmer extends StatelessWidget {
  const CustomeUserProfileTileShimmer({
    super.key,
    required this.icon,
    this.onPressed,
  });
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CustomeShimmerEffect(width: 50, height: 50),
      title: const CustomeShimmerEffect(width: 25, height: 5),
      subtitle: const CustomeShimmerEffect(width: 100, height: 10),
      trailing: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}
