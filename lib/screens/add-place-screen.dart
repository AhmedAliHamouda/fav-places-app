import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/localization/localication-methods.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/places-provider.dart';
import 'package:places_app/widgets/image-input.dart';
import 'package:places_app/widgets/location-input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place-screen';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectedImage(File pickImage) {
    _pickedImage = pickImage;
  }

  void _selectedPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<Places>(context, listen: false)
        .addNewPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTextTranslated(context, 'add_place')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: getTextTranslated(context, 'title_place'),
                        hintText: getTextTranslated(context, 'name_place_hint'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ImageInput(_selectedImage),
                    SizedBox(
                      height: 20.0,
                    ),
                    LocationInput(_selectedPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
            child: Text(
              getTextTranslated(context, 'add_place'),
              style: TextStyle(fontSize: 18.0),
            ),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
