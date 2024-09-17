import 'package:cars_equipments_shop/core/functions/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/shared/widgets/custome_circular_container.dart';
import '../../../../core/shared/widgets/custome_rounded_container.dart';
import '../../../../core/shared/widgets/custome_rounded_image.dart';
import '../../data/models/shop_model.dart';
import '../bloc/add_delete_edit_shop/add_edit_delete_shop_bloc.dart';
import '../pages/edit_shop_page.dart';

class SingleWorkshopWidget extends StatefulWidget {
  const SingleWorkshopWidget({
    super.key,
    required this.shop,
    required this.margin,
  });
  final ShopModel shop;
  final double margin;

  @override
  State<SingleWorkshopWidget> createState() => _SingleWorkshopWidgetState();
}

class _SingleWorkshopWidgetState extends State<SingleWorkshopWidget> {
  String? status;
  FirebaseAuth? auth;
  @override
  void initState() {
    status = getShopStatus(widget.shop);
    auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => push(context, ShopDetailsPage(shop: widget.shop)),
      child: CustomeRoundedContainer(
        margin: EdgeInsets.only(bottom: widget.margin),
        backgroundColor: Colors.grey.withOpacity(0.1),
        width: double.infinity,
        height: 270,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomeRoundedImage(
                    imagePath: widget.shop.image!,
                    width: double.infinity,
                    type: 'image',
                    fit: BoxFit.fill,
                    height: 180,
                    isNetworkImage: true,
                  ),
                ),
                auth?.currentUser?.uid == widget.shop.userId
                    ? Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomeRoundedContainer(
                                width: 50,
                                height: 50,
                                child: IconButton(
                                  onPressed: () {
                                    push(
                                      context,
                                      EditShopPage(shop: widget.shop),
                                    );
                                  },
                                  icon: const Icon(Iconsax.edit),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: TSizes.spaceBtnItems / 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomeRoundedContainer(
                                width: 50,
                                height: 50,
                                child: IconButton(
                                  onPressed: () {
                                    context.read<AddEditDeleteShopBloc>().add(
                                          DeleteExistShopEvent(
                                              productId:
                                                  widget.shop.dateAdded!),
                                        );
                                  },
                                  icon: const Icon(Icons.close_outlined),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(height: TSizes.spaceBtnItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shop.name!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        children: [
                          Text(
                            status!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: TSizes.spaceBtnItems / 2),
                          CustomeCircularContainer(
                            width: 15,
                            height: 15,
                            backgroundColor:
                                status == 'Online' ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.shop.address!.city,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getShopStatus(ShopModel shop) {
    String currentDay = DateFormat('EEEE').format(DateTime.now());
    TimeOfDay currentTime = TimeOfDay.now();

    for (OpenDay open in shop.opens!) {
      if (open.day == currentDay) {
        String openingTime = open.fromTime.format(context);
        String closingTime = open.toTime.format(context);

        if (isTimeInRange(
          currentTime,
          parseTime(openingTime),
          parseTime(closingTime),
        )) {
          return "Online";
        }
      }
    }
    return "Offline";
  }

  TimeOfDay parseTime(String time) {
    final format = DateFormat.jm(); //"8:00 AM" -> TimeOfDay(8, 0)
    DateTime dateTime = format.parse(time);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  bool isTimeInRange(
    TimeOfDay currentTime,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) {
    final now = DateTime.now();
    final currentDateTime = DateTime(
        now.year, now.month, now.day, currentTime.hour, currentTime.minute);
    final startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    final endDateTime =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    return currentDateTime.isAfter(startDateTime) &&
        currentDateTime.isBefore(endDateTime);
  }
}
