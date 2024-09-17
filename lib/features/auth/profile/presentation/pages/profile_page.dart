import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/shared/widgets/custome_loading.dart';
import 'package:cars_equipments_shop/features/auth/profile/data/models/user_model.dart';
import 'package:cars_equipments_shop/features/auth/profile/presentation/blocs/my_profile_bloc/profile_bloc.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/functions/pick_image.dart';
import '../../../../../core/shared/bloc/shared_bloc/shared_bloc.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../../core/shared/widgets/upload_single_network_image.dart';

import '../../../../../main.dart';
import '../widgets/custome_profile_menu.dart';
import '../../../../../core/shared/widgets/custome_seaction_heading.dart';
import '../../data/local/profile_local.dart';
import '../widgets/edit_date.dart';
import '../widgets/edit_email.dart';
import '../widgets/edit_gender.dart';
import '../widgets/edit_name.dart';
import '../widgets/edit_phone.dart';
import '../../../../../core/shared/pages/view_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences? sharedPreferences;
  String cachedUser = '';
  Future<void> _initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      cachedUser = sharedPreferences?.getString('user') ?? '';
    });
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<ProfileBloc>(context).add(FetchUserDataEvent());
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          SharedConstants.sharedProfile.tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is FetchUserDataErrorState) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    title: SharedConstants.messageWrongAlertTitle.tr(context),
                    message: state.errorMsg,
                    type: ContentType.failure,
                  );
                } else if (state is FetchUserDataSuccessState) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    title: SharedConstants.messageSuccessAlertTitle.tr(context),
                    message:
                        SharedConstants.sharedFetchedSuccessfully.tr(context),
                    type: ContentType.success,
                  );
                } else if (state is FetchUserDataNoInternetConnection) {
                  THelperFunctions.showSnackBar(
                    context: context,
                    message:
                        SharedConstants.messageNoInternetConnection.tr(context),
                    title: SharedConstants.messageAlertTitle.tr(context),
                    type: ContentType.warning,
                  );
                } else if (state is LogoutState) {
                  pushAndRemoveUntil(context, const MyApp(), false);
                }
              },
              builder: (context, state) {
                if (state is FetchUserDataLoadingState) {
                  if (cachedUser.isEmpty) {
                    return const LoadingWidget();
                  } else {
                    final user = cachedUser;
                    return Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text('Fetching new data'),
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtnItems),
                        ProfileScreen(
                          user: UserModel.fromJson(
                            jsonDecode(user),
                          ),
                        ),
                      ],
                    );
                  }
                } else if (state is FetchUserDataSuccessState) {
                  final user = state.userModel;
                  return ProfileScreen(user: user);
                } else if (state is FetchUserDataNoInternetConnection) {
                  final user = state.userModel;
                  return ProfileScreen(user: user);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? thmbnail;
  copyText({required String text}) {
    Clipboard.setData(
      ClipboardData(text: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UploadSingleNetworkImage(
          thmbnail: widget.user.userImage,
          title: SharedConstants.sharedProfile,
          onTap: () {
            if (widget.user.userImage != null) {
              push(
                context,
                ViewImage(
                  networkImage: widget.user.userImage,
                  storageImage: thmbnail,
                  isNetwork: thmbnail != null ? false : true,
                ),
              );
            }
          },
          file: thmbnail,
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
        BlocConsumer<SharedBloc, SharedState>(
          listener: (context, state) {
            if (state is NoInternetConnectionState) {
              THelperFunctions.showSnackBar(
                context: context,
                title: SharedConstants.messageWrongAlertTitle.tr(context),
                message:
                    SharedConstants.messageNoInternetConnection.tr(context),
                type: ContentType.failure,
              );
              setState(() {
                thmbnail = null;
              });
            } else if (state is UploadImageErrorState) {
              THelperFunctions.showSnackBar(
                context: context,
                title: SharedConstants.messageWrongAlertTitle.tr(context),
                message: state.errorMsg,
                type: ContentType.failure,
              );
            } else if (state is UploadImageSuccessState) {
              setState(() {
                thmbnail = state.image;
              });
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () async {
                final pickedImage = await pickImage();
                if (pickedImage != null) {
                  thmbnail = File(pickedImage.path);
                }
                BlocProvider.of<SharedBloc>(context).add(
                  UploadImageEvent(
                    collection: 'users',
                    fieldChanged: 'user_image',
                    image: thmbnail!,
                  ),
                );
              },
              child: state is UploadImageLoadingState
                  ? const LoadingWidget(
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    )
                  : const Text('Change Profile Image'),
            );
          },
        ),
        const SizedBox(height: TSizes.spaceBtnItems / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtnItems),
        CustomeSeactionHeading(
          title:
              "${SharedConstants.sharedProfile.tr(context)} ${ProfileConstants.profileInformation.tr(context)}",
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
        CustomeProfileMenu(
            anotherIcon: true,
            title: ProfileConstants.profileUserId.tr(context),
            value: widget.user.userId ?? "",
            iconData: Iconsax.copy,
            onPressed: () {
              copyText(text: widget.user.userId ?? "");
            }),
        CustomeProfileMenu(
            anotherIcon: true,
            title: ProfileConstants.profileUserName.tr(context),
            value: widget.user.userName!,
            iconData: Iconsax.copy,
            onPressed: () {
              copyText(text: widget.user.userName ?? "");
            }),
        CustomeProfileMenu(
            anotherIcon: true,
            title: widget.user.providerType == "phone"
                ? ProfileConstants.profileUserPhone.tr(context)
                : ProfileConstants.profileUserEmail.tr(context),
            value: widget.user.providerType == "phone"
                ? "+${widget.user.userPhone!.countryCode!}${widget.user.userPhone!.phoneNumber!}"
                : widget.user.userEmail!,
            iconData: Iconsax.copy,
            onPressed: () {
              copyText(text: widget.user.userEmail ?? "");
            }),
        CustomeProfileMenu(
          title:
              "${ProfileConstants.profileAccount.tr(context)} ${ProfileConstants.profileUserAccountCreatedDate.tr(context)}",
          value: widget.user.accountDateCreation ?? "",
          noIcon: true,
        ),
        const SizedBox(height: TSizes.spaceBtnItems / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtnItems),
        CustomeSeactionHeading(
          title:
              "${ProfileConstants.profilePersonal.tr(context)} ${ProfileConstants.profileInformation.tr(context)}",
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
        CustomeProfileMenu(
            title: ProfileConstants.profileUserFullName.tr(context),
            value: "${widget.user.userFirst!} ${widget.user.userLast!}",
            onPressed: () {
              push(
                context,
                EditName(
                  firstName: widget.user.userFirst ?? '',
                  lastName: widget.user.userLast ?? '',
                  onNameUpdated: (updatedFirstName, updatedLastName) {
                    setState(() {
                      widget.user.userFirst = updatedFirstName;
                      widget.user.userLast = updatedLastName;
                    });
                  },
                ),
              );
            }),
        widget.user.providerType == "phone"
            ? CustomeProfileMenu(
                title: ProfileConstants.profileUserEmail.tr(context),
                value: widget.user.userEmail!,
                onPressed: () {
                  push(
                    context,
                    EditEmail(
                      email: widget.user.userEmail ?? '',
                      onEmailUpdated: (updatedEmail) {
                        setState(() {
                          widget.user.userFirst = updatedEmail;
                        });
                      },
                    ),
                  );
                })
            : CustomeProfileMenu(
                title: ProfileConstants.profileUserPhone.tr(context),
                value: widget.user.userPhone!.phoneNumber!,
                onPressed: () {
                  push(
                    context,
                    EditPhone(
                      phone: PhoneNumberModel(
                        phoneNumber: widget.user.userPhone!.phoneNumber,
                        countryCode: widget.user.userPhone!.countryCode,
                      ),
                      onPhoneUpdated: (updatedPhoneNumber, updatedCountryCode) {
                        setState(() {
                          widget.user.userPhone!.phoneNumber =
                              updatedPhoneNumber;
                          widget.user.userPhone!.countryCode =
                              updatedCountryCode;
                        });
                      },
                    ),
                  );
                }),
        CustomeProfileMenu(
            title: ProfileConstants.profileUserGender.tr(context),
            value: widget.user.userGender ?? '',
            onPressed: () {
              push(
                context,
                EditGender(
                  gender: widget.user.userGender ?? '',
                  onGenderUpdated: (updatedGender) {
                    setState(() {
                      widget.user.userGender = updatedGender;
                    });
                  },
                ),
              );
            }),
        CustomeProfileMenu(
            title: ProfileConstants.profileUserDateOfBirth.tr(context),
            value: widget.user.userDateBirth!,
            onPressed: () {
              push(
                context,
                EditDate(
                  date: widget.user.userDateBirth ?? '',
                  onBirthDateUpdated: (updatedDateOfBirth) {
                    setState(() {
                      widget.user.userDateBirth = updatedDateOfBirth;
                    });
                  },
                ),
              );
            }),
        const SizedBox(
          height: TSizes.spaceBtnItems / 2,
        ),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtnItems),
        TextButton(
          onPressed: () {},
          child: Text(
            "${SharedConstants.sharedDelete.tr(context)} ${ProfileConstants.profileAccount.tr(context)}",
            style: const TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context).add(LogoutEvent());
          },
          child: Text(
            ProfileConstants.profileLogout.tr(context),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
