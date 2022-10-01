import 'dart:convert';
import 'dart:ui';

import 'package:feature_oriented/core/utils/shared_prefs_keys.dart';
import 'package:intl/intl.dart';
import '../../app/injection_container.dart';


import 'package:feature_oriented/core/error/exceptions.dart';
import 'package:feature_oriented/core/storage/shared_prefs_manager_impl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
 
part 'translation_extensions.dart';
part 'localized_strings.dart';

class LocalizationManager extends SharedPrefsManagerImpl {
  var appLocale = const Locale('en');

  Locale setUpAppLanguage() {
    var storedLanguageCode;
    try {
      storedLanguageCode = getCached(SharedPrefsKeys.appLanguage);
      appLocale = Locale(storedLanguageCode.toString());
    } on CacheException {
      appLocale = Locale(appLocale.languageCode);
      storedLanguageCode = appLocale.languageCode;
      saveIntoCache(SharedPrefsKeys.appLanguage, storedLanguageCode);
    }

    updateAppLanguage();
    layoutDirection = _getLayoutDirection(appLocale.languageCode);
    return appLocale;
  }

  Future<void> changeLanguage({required String chooseLang}) async {
    clearCached(SharedPrefsKeys.appLanguage);
    saveIntoCache(SharedPrefsKeys.appLanguage, chooseLang);
    appLocale = Locale(chooseLang);
    updateAppLanguage();
  }

  Future<void> updateAppLanguage() async {
    layoutDirection = _getLayoutDirection(appLocale.languageCode);
    String _langFIle = await rootBundle
        .loadString('assets/lang/${appLocale.languageCode}.json');
    Map<String, dynamic> translationsJson = jsonDecode(_langFIle);
    // LoggerUtils().makeLoggerInfo(_langFIle.toString());
    initTranslations(translationsJson);
  }

  Map<String, String> translationsMap = <String, String>{};

  void initTranslations(var jsonData) {
    if (jsonData == null) {
      return;
    }
    jsonData.forEach((k, v) {
      translationsMap[k] = v;
    });
  }

  String getTranslationOf(String key) {
    if (translationsMap.containsKey(key)) {
      return translationsMap[key]!;
    }
    return key;
  }

  LayoutDirection layoutDirection = LayoutDirection.lTR;

  bool get isLayoutDirectionLTR => layoutDirection == LayoutDirection.lTR;

  LayoutDirection _getLayoutDirection(lang) {
    if (lang == 'en') {
      return LayoutDirection.lTR;
    } else {
      return LayoutDirection.rTL;
    }
  }

  List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('ar'),
      ];

  get localizationsDelegates => const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ];
}

enum LayoutDirection { rTL, lTR }


