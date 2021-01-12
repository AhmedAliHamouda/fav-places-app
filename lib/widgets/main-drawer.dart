import 'package:flutter/material.dart';
import 'package:places_app/localization/localication-methods.dart';
import 'package:places_app/screens/places-screen.dart';
import 'package:places_app/screens/settings-screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(getTextTranslated(context, 'places')),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          SizedBox(height: 40,),
          ListTile(
            leading: Icon(Icons.place_rounded),
            title: Text(getTextTranslated(context, 'places')),
            onTap: (){
              Navigator.pushReplacementNamed(context, PlacesScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(getTextTranslated(context, 'settings')),
            onTap: (){
              Navigator.pushReplacementNamed(context, SettingsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle_sharp),
            title: Text(getTextTranslated(context, 'about_us')),
            onTap: (){},
          ),
          Divider(),
        ],
      ),
    );
  }
}
