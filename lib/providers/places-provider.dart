import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/helpers/db-helper.dart';
import 'package:places_app/helpers/location-helper.dart';
import 'package:places_app/models/place.dart';

class Places extends ChangeNotifier {
  List<Place> _placesItems = [];

  List<Place> get placesItems {
    return [..._placesItems];
  }

  Place findPlaceById(String id) {
    return _placesItems.firstWhere((place) => place.id == id);
  }

  Future<void> addNewPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: updateLocation,
      image: pickedImage,
    );
    _placesItems.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      table: 'user_places',
      data: {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  Future<void> fetchData() async {
    final dataList = await DBHelper.getData('user_places');
    _placesItems = dataList
        .map(
          (dbItem) => Place(
            id: dbItem['id'],
            title: dbItem['title'],
            image: File(dbItem['image']),
            location: PlaceLocation(
              latitude: dbItem['loc_lat'],
              longitude: dbItem['loc_lng'],
              address: dbItem['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
