import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places_app/localization/localication-methods.dart';
import 'package:places_app/localization/set-localization.dart';
import 'package:places_app/providers/places-provider.dart';
import 'package:places_app/screens/add-place-screen.dart';
import 'package:places_app/screens/place-detail-screen.dart';
import 'package:places_app/screens/places-screen.dart';
import 'package:places_app/screens/settings-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  static void setLocale(BuildContext context,Locale locale){
    _MyAppState state=context.findAncestorStateOfType<_MyAppState>();
    state.setLocaleApp(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocaleDataFromStorage().then((getLocale) {
      setState(() {
        this._locale=getLocale;
      });
    });

  }
  void setLocaleApp(Locale locale){
    setState(() {
      _locale=locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Places',
        theme: ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
        home: PlacesScreen(),
        routes: {
          PlacesScreen.routeName:(context)=>PlacesScreen(),
          AddPlaceScreen.routeName:(context)=>AddPlaceScreen(),
          PlaceDetailScreen.routeName:(context)=>PlaceDetailScreen(),
          SettingsScreen.routeName:(context)=>SettingsScreen(),
        },
        locale: _locale,
        supportedLocales: [
          Locale('en',''),
          Locale('ar',''),
        ],
        localizationsDelegates: [
          SetLocalization.localizationsDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

      ),
    );
  }
}
