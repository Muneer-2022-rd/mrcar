import 'package:flutter/material.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/widgets/custome_seaction_heading.dart';

class UpdateAddressWidget extends StatelessWidget {
  const UpdateAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomeSeactionHeading(
                title: "Update Address",
              ),
              SizedBox(height: TSizes.spaceBtnItems / 2),
              
            ],
          ),
        ),
      ),
    );
  }
}
