//const GOOGLE_MAPS_API_KEY='AIzaSyB6Uh57EeCKxRFfnr0TXLKGVtD8pjCKFzM';

import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_MAPS_API_KEY = 'AIzaSyAV1Howvkn2VJG9x5K7BWqDvl5GJZJQ3CY';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    String locationURL =
        'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_MAPS_API_KEY';
    return locationURL;
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_MAPS_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_MAPS_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
