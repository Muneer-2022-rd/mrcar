import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';

class CustomeSettingMenuTile extends StatelessWidget {
  const CustomeSettingMenuTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leadingIcon,
    this.trailing,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final IconData leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon, color: Theme.of(context).primaryColor),
      title: Text(
        title.tr(context),
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(),
      ),
      subtitle: Text(
        subTitle.tr(context),
        style: Theme.of(context).textTheme.bodyMedium!,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
