import 'package:flutter/material.dart';
import 'package:places_app/localization/set-localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTextTranslated(BuildContext context, String key) {
  return SetLocalization.of(context).getTranslateValue(key);
}

Future<Locale> setLocaleDataToStorage(String languageCode) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('lang_code', languageCode);
  return Locale(languageCode,'');
}

Future<Locale> getLocaleDataFromStorage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String languageCode = preferences.getString('lang_code') ?? 'en';
  return Locale(languageCode,'');
}
