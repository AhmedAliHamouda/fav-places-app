import 'package:flutter/material.dart';
import 'package:places_app/providers/places-provider.dart';
import 'package:places_app/screens/map-screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = 'place-detail-screen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<Places>(context).findPlaceById(id);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.6,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //titlePadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              title:  Text(selectedPlace.title),
              background: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 20,
                ),
                Text(
                  selectedPlace.location.address,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => MapScreen(
                                initialLocation: selectedPlace.location,
                                isSelecting: false,
                              )),
                    );
                  },
                  child: Text(
                    'Show On Map',
                    style: TextStyle(fontSize: 17),
                  ),
                  textColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 800.0,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
