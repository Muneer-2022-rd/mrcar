import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../address/data/model/address_model.dart';

class ShopModel {
  final String? name;
  final AddressModel? address;
  String? image;
  final String? dateAdded;
  final List<String>? services;
  List<String>? images;
  List<OpenDay>? opens;
  final String? userId;

  ShopModel({
    required this.name,
    required this.address,
    required this.image,
    required this.dateAdded,
    required this.services,
    required this.images,
    required this.opens,
    required this.userId,
  });

  ShopModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['location'] != null
            ? AddressModel.fromJson(json['location'])
            : null,
        image = json['image'],
        dateAdded = json['dateAdded'],
        userId = json['userId'],
        services =
            json['services'] != null ? List<String>.from(json['services']) : [],
        images =
            json['images'] != null ? List<String>.from(json['images']) : [],
        opens = json['opens'] != null
            ? List<OpenDay>.from(
                json['opens'].map((open) => OpenDay.fromJson(open)))
            : [];

  factory ShopModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ShopModel(
      name: data['name'],
      address: data['location'] != null
          ? AddressModel.fromJson(data['location'])
          : null,
      image: data['image'],
      dateAdded: data['dateAdded'],
      userId: data['userId'],
      services:
          data['services'] != null ? List<String>.from(data['services']) : [],
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      opens: data['opens'] != null
          ? List<OpenDay>.from(
              data['opens'].map((open) => OpenDay.fromJson(open)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;

    if (address != null) {
      data['location'] = address!.toJson();
    }
    data['opens'] = opens?.map((open) => open.toJson()).toList();
    data['image'] = image;
    data['dateAdded'] = dateAdded;
    data['services'] = services;
    data['images'] = images;
    data['userId'] = userId;
    return data;
  }
}

class OpenDay {
  String day;
  TimeOfDay fromTime;
  TimeOfDay toTime;

  OpenDay({required this.day, required this.fromTime, required this.toTime});

  // OpenDay.fromJson(Map<String, dynamic> json)
  //     : day = json['day'],
  //       fromTime = json['fromTime'],
  //       toTime = json['toTime'];

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'fromTime': {
        'hour': fromTime.hour,
        'minute': fromTime.minute,
        'period': fromTime.period,
      },
      'toTime': {
        'hour': toTime.hour,
        'minute': toTime.minute,
        'period': toTime.period,
      },
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'fromTime': '${fromTime.hour}:${fromTime.minute} ${fromTime.period}',
      'toTime': '${toTime.hour}:${toTime.minute} ${toTime.period}',
    };
  }

  factory OpenDay.fromMap(Map<String, dynamic> map) {
    return OpenDay(
      day: map['day'],
      fromTime: TimeOfDay(
        hour: map['fromTime']['hour'],
        minute: map['fromTime']['minute'],
      ),
      toTime: TimeOfDay(
        hour: map['toTime']['hour'],
        minute: map['toTime']['minute'],
      ),
    );
  }

  factory OpenDay.fromJson(Map<String, dynamic> json) {
    final fromTimeParts = json['fromTime'].split(':');
    final toTimeParts = json['toTime'].split(':');

    return OpenDay(
      day: json['day'],
      fromTime: TimeOfDay(
        hour: int.parse(fromTimeParts[0]),
        minute: int.parse(fromTimeParts[1]),
      ),
      toTime: TimeOfDay(
        hour: int.parse(toTimeParts[0]),
        minute: int.parse(toTimeParts[1]),
      ),
    );
  }
}
