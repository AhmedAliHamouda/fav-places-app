import 'package:flutter/material.dart';
import 'package:places_app/localization/localication-methods.dart';
import 'package:places_app/widgets/dialog.dart';
import 'package:places_app/widgets/main-drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName='settings-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(getTextTranslated(context, 'settings')),),
      body: Column(children: [
        ListTile(
          leading: Icon(Icons.language_rounded),
          title: Text(getTextTranslated(context, 'other_lang')),
          onTap: (){
            showDialog(context: context,builder: (context)=>SingleChoiceDialog());
          },
        ),
      ],),
      drawer: MainDrawer(),
    );
  }
}
