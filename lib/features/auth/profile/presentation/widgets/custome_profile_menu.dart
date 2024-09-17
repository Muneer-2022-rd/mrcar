import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomeProfileMenu extends StatelessWidget {
  const CustomeProfileMenu({
    super.key,
    required this.title,
    required this.value,
    this.onPressed,
    this.iconData,
    this.anotherIcon = false,
    this.noIcon = false,
  });
  final String title;
  final String value;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final bool anotherIcon;
  final bool noIcon;

  @override
  Widget build(BuildContext context) {
    // final String lang = LocaleCubit.get(context).state.locale.toString();
    // print(lang);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              noIcon == false
                  ? anotherIcon
                      ? iconData
                      : Iconsax.edit
                  : null,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
