import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/functions/helper_functions.dart';
import '../../../../core/functions/pick_image.dart';
import '../../../../core/shared/bloc/image_bloc/images_bloc.dart';
import '../../../../core/shared/data/local/shared_local.dart';
import '../../../../core/shared/widgets/addList_of_items.dart';
import '../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../core/shared/widgets/custome_text_field_with_svg_picture_widget.dart';
import '../../../address/data/model/address_model.dart';
import '../../data/models/shop_model.dart';
import '../bloc/add_delete_edit_shop/add_edit_delete_shop_bloc.dart';
import '../bloc/my_shops_bloc/my_shops_bloc.dart';
import '../bloc/shop_bloc/shop_bloc.dart';
import '../widgets/add/my_addresses_list.dart';
import '../widgets/add/upload_multi_images.dart';
import '../widgets/add/upload_single_image.dart';

class EditShopPage extends StatefulWidget {
  final ShopModel shop;
  const EditShopPage({super.key, required this.shop});

  @override
  State<EditShopPage> createState() => _EditShopPageState();
}

class _EditShopPageState extends State<EditShopPage> {
  late TextEditingController nameC;
  late TextEditingController serviceC;
  List<String> serviceList = [];
  late AddressModel? selectedAddress;
  List<OpenDay> selectedDayTimes = [];
  List<OpenDay> openDays = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<File> imagesList = [];
  void selectImages() async {
    final pickedImages = await pickListImages();
    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        imagesList.addAll(pickedImages);
      });
    }
  }

  File? thmbnail;
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        thmbnail = File(pickedImage.path);
      });
    }
  }

  void deleteImage() async {
    setState(() {
      thmbnail = null;
    });
  }

  @override
  void initState() {
    nameC = TextEditingController(text: widget.shop.name);
    serviceC = TextEditingController();
    serviceList = widget.shop.services!;
    context.read<AddEditDeleteShopBloc>().add(GetMyAddressesInShopEvent());
    selectedAddress = widget.shop.address;
    selectedDayTimes = widget.shop.opens!;
    openDays = widget.shop.opens!;
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    serviceC.dispose();
    super.dispose();
  }

  List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  void _addDay() async {
    String? selectedDay = await _selectDay();
    if (selectedDay != null) {
      TimeOfDay? fromTime = await _selectTime('Select From Time');
      TimeOfDay? toTime = await _selectTime('Select To Time');

      if (fromTime != null && toTime != null) {
        setState(() {
          openDays.add(
            OpenDay(day: selectedDay, fromTime: fromTime, toTime: toTime),
          );
        });
      }
    }
  }

  Future<String?> _selectDay() async {
    List<String> availableDays = allDays
        .where((day) => !openDays.any((openDay) => openDay.day == day))
        .toList();

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a Day'),
          children: availableDays.map((day) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, day),
              child: Text(day),
            );
          }).toList(),
        );
      },
    );
  }

  Future<TimeOfDay?> _selectTime(String title) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          'Edit Workshop',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: BlocConsumer<AddEditDeleteShopBloc, AddEditDeleteShopState>(
        listener: (context, state) {
          if (state is EditShopErrorState) {
            THelperFunctions.showSnackBar(
              context: context,
              message: state.errorMsg,
              title: SharedConstants.messageWrongAlertTitle.tr(context),
              type: ContentType.failure,
            );
          } else if (state is EditShopLoadedState) {
            THelperFunctions.showSnackBar(
              context: context,
              message: 'Workshop Edited Successfully',
              title: SharedConstants.messageSuccessAlertTitle.tr(context),
              type: ContentType.success,
            );
            context.read<ShopBloc>().add(LoadShopsDataEvent());
            context.read<MyShopsBloc>().add(LoadMyShopsDataEvent());
            Navigator.of(context).pop();
          }
          if (state is MyAddressesInShopErrorState) {
            THelperFunctions.showSnackBar(
              context: context,
              message: state.errorMsg,
              title: SharedConstants.messageWrongAlertTitle.tr(context),
              type: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: TSizes.spaceBtnItems / 2),
                    CustomeTextFieldWithSvgPictureWidget(
                      keyboardType: TextInputType.text,
                      controller: nameC,
                      imagePath: TImages.name,
                      label: 'Name',
                    ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shop Open Hours',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(fontSizeDelta: 8),
                        ),
                        ElevatedButton(
                          onPressed: _addDay,
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: openDays.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final day = openDays[index];
                        return Card(
                          child: ListTile(
                            title: Text(day.day),
                            subtitle: Text(
                                '${day.fromTime.format(context)} - ${day.toTime.format(context)}'),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  openDays.remove(day);
                                });
                              },
                              icon: const Icon(Iconsax.close_circle),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    thmbnail == null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  widget.shop.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : UploadSingleImage(
                            thmbnail: thmbnail,
                            deleteImage: deleteImage,
                            uploadImage: selectImage,
                            title: 'Workshop',
                          ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    // here
                    const SizedBox(height: TSizes.spaceBtnItems),
                    MyAddressesList(
                      address: selectedAddress!,
                      onAddressSelected: (address) {
                        setState(() {
                          selectedAddress = address;
                        });
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    AddListOfItems(
                      title: 'Services',
                      controller: serviceC,
                      list: serviceList,
                    ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    widget.shop.images!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Previous Images',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(fontSizeDelta: 8),
                              ),
                              const SizedBox(height: TSizes.spaceBtnItems),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: widget.shop.images!.map((image) {
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          image,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      BlocListener<ImagesBloc, ImagesState>(
                                        listener: (context, state) {
                                          if (state
                                              is DeleteImageSuccessState) {
                                            setState(() {
                                              widget.shop.images!.remove(
                                                  state.deletedImageUrl);
                                            });
                                          }
                                        },
                                        child: Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () {
                                              context.read<ImagesBloc>().add(
                                                    DeleteImageEvent(
                                                      collection: 'cars',
                                                      productId: widget
                                                          .shop.dateAdded!,
                                                      imageUrl: image,
                                                    ),
                                                  );
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }).toList(),
                              )
                            ],
                          )
                        : const SizedBox.shrink(),
                    UploadMultiImages(
                      images: imagesList,
                      uploadImages: () => selectImages(),
                    ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    state is EditShopLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AddEditDeleteShopBloc>().add(
                                      EditExistShopEvent(
                                          name: nameC.text,
                                          address: selectedAddress!,
                                          image: thmbnail,
                                          services: serviceList,
                                          images: imagesList,
                                          opens: selectedDayTimes,
                                          productId: widget.shop.dateAdded),
                                    );
                              }
                            },
                            child: const Text('Edit'),
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
