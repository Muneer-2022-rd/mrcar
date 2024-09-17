import 'dart:convert';

import 'auto_complete_prediction.dart';

class PlaceAutocompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions; // Corrected the spelling

  PlaceAutocompleteResponse({
    this.status,
    this.predictions,
  });

  // Updated to handle the Map<String, dynamic>
  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteResponse(
      status: json['status'],
      predictions: json['predictions'] != null // Corrected the spelling
          ? (json['predictions'] as List)
              .map<AutocompletePrediction>(
                  (item) => AutocompletePrediction.fromJson(item))
              .toList()
          : null,
    );
  }

  static PlaceAutocompleteResponse parseAutoCompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutocompleteResponse.fromJson(parsed);
  }
}
