import 'package:flutter/material.dart';
import 'package:places_app/providers/places-provider.dart';
import 'package:places_app/screens/add-place-screen.dart';
import 'package:places_app/screens/place-detail-screen.dart';
import 'package:places_app/screens/places-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Places',
        theme: ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
        home: PlacesScreen(),
        routes: {
          AddPlaceScreen.routeName:(context)=>AddPlaceScreen(),
          PlaceDetailScreen.routeName:(context)=>PlaceDetailScreen(),
        },
      ),
    );
  }
}
