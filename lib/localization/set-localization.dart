import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetLocalization {
  final Locale locale;

  SetLocalization(this.locale);

  static SetLocalization of(BuildContext context) {
    return Localizations.of<SetLocalization>(context, SetLocalization);
  }
  Map<String, String> _localizedValues;

 static LocalizationsDelegate<SetLocalization> localizationsDelegate =_GetLocalizationDelegate();

  Future loadLocalizedData() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslateValue(String key){
    return _localizedValues[key];
  }
}

class _GetLocalizationDelegate extends LocalizationsDelegate<SetLocalization>{
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<SetLocalization> load(Locale locale) async {
    // TODO: implement load
    //throw UnimplementedError();
    SetLocalization  setLocalization= SetLocalization(locale);
    await setLocalization.loadLocalizedData();
    return setLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<SetLocalization> old) {
    // TODO: implement shouldReload
    return true;
  }
}