import 'package:flutter/material.dart';
import 'package:places_app/localization/localication-methods.dart';
import 'package:places_app/main.dart';

class SingleChoiceDialog extends StatefulWidget {
  @override
  _SingleChoiceDialogState createState() => _SingleChoiceDialogState();
}

class _SingleChoiceDialogState extends State<SingleChoiceDialog> {
  Locale _tempLocal;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        getTextTranslated(context, 'choose_lang'),
        textAlign: TextAlign.center,
      ),
      children: [
        SimpleDialogOption(
          child: Text(
            getTextTranslated(context, 'lang_ar'),
            //' 🇪🇬 Arabic',
            style: TextStyle(fontSize: 18.0),
          ),
          onPressed: () async {
            //_tempLocal=Locale('ar','');
            _tempLocal = await setLocaleDataToStorage('ar');
            Navigator.pop(context);
            MyApp.setLocale(context, _tempLocal);
          },
        ),
        SimpleDialogOption(
          child: Text(
            getTextTranslated(context, 'lang_en'),
            //' 🇺🇸 English',
            style: TextStyle(fontSize: 18.0),
          ),
          onPressed: () async {
            //_tempLocal = Locale('en', '');
            _tempLocal = await setLocaleDataToStorage('en');
            Navigator.pop(context);
            MyApp.setLocale(context, _tempLocal);
          },
        ),
      ],
    );
  }
}
