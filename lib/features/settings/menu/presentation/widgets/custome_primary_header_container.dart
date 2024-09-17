
import 'package:flutter/material.dart';

import '../../../../../../../core/constants/colors.dart';
import '../../../../../core/shared/widgets/custome_circular_container.dart';
import 'custome_curved_edges_widget.dart';

class CustomePrimaryHeaderContainer extends StatelessWidget {
  const CustomePrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomeCurvedEdgesWidget(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CustomeCircularContainer(
                backgroundColor: TColors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CustomeCircularContainer(
                backgroundColor: TColors.white.withOpacity(0.1),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
