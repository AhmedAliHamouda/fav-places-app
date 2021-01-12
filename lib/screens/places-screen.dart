import 'package:flutter/material.dart';
import 'package:places_app/localization/localication-methods.dart';
import 'package:places_app/localization/set-localization.dart';
import 'package:places_app/providers/places-provider.dart';
import 'package:places_app/screens/add-place-screen.dart';
import 'package:places_app/screens/place-detail-screen.dart';
import 'package:places_app/widgets/main-drawer.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatelessWidget {
  static const routeName='places-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTextTranslated(context, 'places')),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                builder: (context, places, child) {
                  if (places.placesItems.length <= 0) {
                    return Center(
                      child: Text(getTextTranslated(context, 'no_places')),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: places.placesItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(places.placesItems[index].image),
                            ),
                            title: Text(places.placesItems[index].title),
                            subtitle: Text(places.placesItems[index].location.address),
                            onTap: (){
                              Navigator.pushNamed(context, PlaceDetailScreen.routeName,arguments:places.placesItems[index].id );
                            },
                          );
                        });
                  }
                },
              ),
      ),
      drawer: MainDrawer(),
    );
  }
}
