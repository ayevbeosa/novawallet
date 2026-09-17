import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoruba_localization/yoruba_localization.dart';

class YorubaDelegateFix extends LocalizationsDelegate<MaterialLocalizations> {
  const YorubaDelegateFix();

  @override
  bool isSupported(Locale locale) {
    // Intercept the correct 'yo' locale code
    return locale.languageCode == 'yo';
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    // Trick the package by feeding it a Locale with 'yr' when Flutter requests 'yo'
    const fakePackageLocale = Locale('yr');

    // Call the original package's material delegate loader
    return YrMaterialLocalizations.delegate.load(fakePackageLocale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) => false;
}

class YorubaCupertinoDelegateFix extends LocalizationsDelegate<CupertinoLocalizations> {
  const YorubaCupertinoDelegateFix();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'yo';

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return YrCupertinoLocalizations.delegate.load(const Locale('yr'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CupertinoLocalizations> old) => false;
}

class YorubaWidgetsDelegateFix extends LocalizationsDelegate<WidgetsLocalizations> {
  const YorubaWidgetsDelegateFix();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'yo';

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    return YrWidgetLocalizations.delegate.load(const Locale('yo'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<WidgetsLocalizations> old) => false;
}
