import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id;
  final String lat;
  final String long;
  final String country;
  final String city;
  final String state;
  final String name;
  final String phone;
  final String? userId;
  final String? dateCreated;

  AddressModel({
    required this.lat,
    required this.long,
    required this.country,
    required this.city,
    required this.state,
    required this.name,
    required this.phone,
    required this.id,
    this.userId,
    this.dateCreated
  });

  AddressModel.empty()
      : id = '',
        lat = '',
        long = '',
        country = '',
        city = '',
        state = '',
        name = '',
        phone = '',
        userId = null,
        dateCreated = '';

  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lat = json['lat'],
        long = json['long'],
        country = json['country'],
        city = json['city'],
        state = json['state'],
        name = json['name'],
        phone = json['phone'],
        userId = json['userId'],
        dateCreated = json['dateCreated'];

  factory AddressModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AddressModel(
      id: data['id'],
      lat: data['lat'],
      long: data['long'],
      country: data['country'],
      city: data['city'],
      state: data['state'],
      name: data['name'],
      phone: data['phone'],
      userId: data['userId'],
      dateCreated: data['dateCreated'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lat'] = lat;
    data['long'] = long;
    data['country'] = country;
    data['city'] = city;
    data['state'] = state;
    data['name'] = name;
    data['phone'] = phone;
    data['userId'] = userId;
    data['dateCreated'] = dateCreated;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.id == id &&
        other.lat == lat &&
        other.long == long &&
        other.country == country &&
        other.city == city &&
        other.state == state &&
        other.name == name &&
        other.phone == phone &&
        other.userId == userId &&
        other.dateCreated == dateCreated;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      lat.hashCode ^
      long.hashCode ^
      country.hashCode ^
      city.hashCode ^
      state.hashCode ^
      name.hashCode ^
      userId.hashCode ^
      dateCreated.hashCode ^
      phone.hashCode;
}
