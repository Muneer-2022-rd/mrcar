import 'dart:async';

import 'package:cars_equipments_shop/core/shared/data/local/shared_local.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/shared/widgets/custome_app_bar.dart';
import '../../data/local/address_local.dart';
import '../blocs/address_operations_bloc/address_operations_bloc.dart';
import '../widgets/add_address_widgets/address_form_fields_widget.dart';
import '../widgets/add_address_widgets/address_map_widget.dart';
import '../widgets/add_address_widgets/address_submit_button.dart';
import '../widgets/add_address_widgets/or_by_map_button.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  late TextEditingController searchC;
  late TextEditingController countryC;
  late TextEditingController nameC;
  late TextEditingController phoneC;
  late TextEditingController cityC;
  late TextEditingController stateC;
  late TextEditingController latC;
  late TextEditingController longC;

  bool showMap = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  Completer<GoogleMapController>? _controller;
  LatLng? _initialLatLng;
  Set<Marker>? _markers;
  CameraPosition? _initialCameraPosition;
  List<Placemark>? _placemarks;
  String? markerId;

  @override
  void initState() {
    _controller = Completer<GoogleMapController>();
    searchC = TextEditingController();
    countryC = TextEditingController();
    nameC = TextEditingController();
    phoneC = TextEditingController();
    cityC = TextEditingController();
    stateC = TextEditingController();
    latC = TextEditingController();
    longC = TextEditingController();
    _initialLatLng = const LatLng(25.2048, 55.2708);
    _initialCameraPosition = CameraPosition(
      target: _initialLatLng!,
      zoom: 14.4746,
    );
    markerId = auth.currentUser!.uid;
    _markers = {
      Marker(
        markerId: MarkerId(markerId!),
        position: _initialLatLng!,
      ),
    };
    super.initState();
  }

  @override
  void dispose() {
    searchC.dispose();
    countryC.dispose();
    nameC.dispose();
    phoneC.dispose();
    cityC.dispose();
    stateC.dispose();
    latC.dispose();
    longC.dispose();
    super.dispose();
  }

  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    goToLocation(_initialLatLng!, moveCamera: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text(
          '${SharedConstants.sharedAdd.tr(context)} ${SharedConstants.sharedNew.tr(context)} ${AddressConstant.addressTitle.tr(context)}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    AddressFormFields(
                      formKey: formKey,
                      nameC: nameC,
                      phoneC: phoneC,
                      countryC: countryC,
                      cityC: cityC,
                      stateC: stateC,
                      latC: latC,
                      longC: longC,
                    ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    if (!showMap)
                      GestureDetector(
                        onTap: _requestPermissionAndShowMap,
                        child: const OrByMapButton(),
                      ),
                    if (showMap)
                      AddressMapWidget(
                        initialLatLng: _initialLatLng!,
                        markers: _markers!,
                        initialCameraPosition: _initialCameraPosition!,
                        onMapTapped: goToLocation,
                        onUpdateCurrentLocation: onUpdateCurrentLocation,
                        onMapCreated: _onMapCreated,
                      ),
                    const SizedBox(height: TSizes.spaceBtnItems),
                    AddressSubmitButton(
                      formKey: formKey,
                      onSubmit: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AddressOperationsBloc>().add(
                                AddNewAddressEvent(
                                  lat: latC.text,
                                  long: longC.text,
                                  country: countryC.text,
                                  city: cityC.text,
                                  state: stateC.text,
                                  name: nameC.text,
                                  phone: phoneC.text,
                                ),
                              );
                          
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _moveCameraToPosition(LatLng latLng,
      {double zoom = 14.0}) async {
    final GoogleMapController controller = await _controller!.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoom),
      ),
    );
  }

  Future<void> onUpdateCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    LatLng latLng = LatLng(position.latitude, position.longitude);
    goToLocation(latLng);
  }

  Future<void> _requestPermissionAndShowMap() async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
    if (await Permission.location.isGranted) {
      setState(() {
        showMap = true;
      });
    }
  }

  goToLocation(LatLng position, {bool moveCamera = true}) async {
    if (moveCamera) {
      _markers = {
        Marker(
          markerId: MarkerId(markerId!),
          position: position,
        ),
      };
    }
    _placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    countryC = TextEditingController(
      text: '${_placemarks!.first.country}',
    );
    cityC = TextEditingController(
      text: '${_placemarks!.first.administrativeArea}',
    );
    stateC = TextEditingController(
      text: '${_placemarks!.first.locality}',
    );
    latC = TextEditingController(
      text: '${position.latitude}',
    );
    longC = TextEditingController(
      text: '${position.longitude}',
    );
    if (moveCamera) {
      _moveCameraToPosition(position);
    }
    setState(() {});
  }
}
