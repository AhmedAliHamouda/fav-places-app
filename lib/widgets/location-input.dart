import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places_app/helpers/location-helper.dart';
import 'package:places_app/localization/localication-methods.dart';
import 'package:places_app/screens/map-screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedPlace;

  LocationInput(this.onSelectedPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreviewLocation(double lat, double lng) {
    final staticMapImageURL = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageURL;
    });
  }

  Future<void> getCurrentLocation() async {
    final locationData = await Location().getLocation();
    _showPreviewLocation(locationData.latitude, locationData.longitude);
    widget.onSelectedPlace(locationData.latitude, locationData.longitude);
  }

  Future<void> _selectedOnMap() async {
    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreviewLocation(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectedPlace(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  getTextTranslated(context, 'no_location'),
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text(getTextTranslated(context, 'current_location')),
              textColor: Theme.of(context).primaryColor,
              onPressed: getCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text(getTextTranslated(context, 'select_on_map')),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectedOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
