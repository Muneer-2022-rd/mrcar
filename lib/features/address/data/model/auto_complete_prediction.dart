class StructuredFormatting {
  final String? mainText;
  final String? secondaryText; // Corrected the spelling from 'secendoryText'

  StructuredFormatting({
    this.mainText,
    this.secondaryText,
  });

  // Updated to handle the Map<String, dynamic>
  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'],
      secondaryText: json['secondary_text'], // Corrected the spelling
    );
  }
}

class AutocompletePrediction {
  final String? description;
  final StructuredFormatting? structuredFormatting;
  final String? placeId;
  final String? reference; // Corrected the spelling from 'refernce'

  AutocompletePrediction({
    this.description,
    this.structuredFormatting,
    this.placeId,
    this.reference,
  });

  // Updated to handle the Map<String, dynamic>
  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'],
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
      placeId: json['place_id'],
      reference: json['reference'], // Corrected the spelling
    );
  }
}
