import 'package:feature_oriented/feature/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'injection_container.dart';
import '../core/localization/localization_manager.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        home: const SplashPage(),
        locale: serviceLocator<LocalizationManager>().setUpAppLanguage(),
        supportedLocales: serviceLocator<LocalizationManager>().supportedLocales,
        fallbackLocale: serviceLocator<LocalizationManager>().supportedLocales.first,
        localizationsDelegates: serviceLocator<LocalizationManager>().localizationsDelegates,
      );
}
