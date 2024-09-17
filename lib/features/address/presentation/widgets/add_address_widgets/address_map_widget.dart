import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/shared/widgets/custome_rounded_container.dart';

class AddressMapWidget extends StatelessWidget {
  final LatLng initialLatLng;
  final Set<Marker> markers;
  final CameraPosition initialCameraPosition;
  final void Function(LatLng) onMapTapped;
  final Function onUpdateCurrentLocation;
  final void Function(GoogleMapController) onMapCreated;

  const AddressMapWidget({
    super.key,
    required this.initialLatLng,
    required this.markers,
    required this.initialCameraPosition,
    required this.onMapTapped,
    required this.onUpdateCurrentLocation,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TextFormField(
        //   controller: searchC,
        //   decoration: const InputDecoration(
        //     border: OutlineInputBorder(),
        //     labelText: 'Search Location',
        //   ),
        //   onChanged: (value) => placeAutoComplate(value),
        // ),
        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: placePredictions.length,
        //   itemBuilder: (context, index) => GestureDetector(
        //     onTap: () {},
        //     child: ListTile(
        //       title: Text(placePredictions[index].description!),
        //     ),
        //   ),
        // ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: GoogleMap(
            gestureRecognizers: {
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            },
            markers: markers,
            onTap: (latLng) => onMapTapped(latLng),
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: onMapCreated,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: CustomeRoundedContainer(
            width: 60,
            height: 60,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () => onUpdateCurrentLocation(),
              icon: const Icon(Iconsax.location),
            ),
          ),
        ),
      ],
    );
  }
}


  // List<AutocompletePrediction> placePredictions = [];

  // void placeAutoComplate(String query) async {
  //   Uri uri =
  //       Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
  //     'input': query,
  //     'key': 'AIzaSyCXFzbmoUWl-IgxTTpi-YtCe_aoiVXKS_8',
  //   });
  //   String? response = await NetworkUtiliti.fetchURL(uri);
  //   if (response != null) {
  //     PlaceAutocompleteResponse result =
  //         PlaceAutocompleteResponse.parseAutoCompleteResult(response);
  //     if (result.predictions != null) {
  //       setState(() {
  //         placePredictions = result.predictions!;
  //       });
  //     }
  //   }
  // }