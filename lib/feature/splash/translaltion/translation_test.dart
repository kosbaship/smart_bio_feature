import 'package:feature_oriented/app/injection_container.dart';
import 'package:feature_oriented/core/localization/localization_manager.dart';
import 'package:flutter/material.dart';

class TranslationPageTest extends StatefulWidget {
  const TranslationPageTest({Key? key}) : super(key: key);

  @override
  State<TranslationPageTest> createState() => _TranslationPageTestState();
}

class _TranslationPageTestState extends State<TranslationPageTest> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LocalizationManager>().isLayoutDirectionLTR
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.appTitle.translate,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await serviceLocator<LocalizationManager>()
                      .changeLanguage(chooseLang: 'en');
                  setState(() {});
                },
                icon: const Text('EN')),
            IconButton(
                onPressed: () async {
                  await serviceLocator<LocalizationManager>()
                      .changeLanguage(chooseLang: 'ar');
                  setState(() {});
                },
                icon: const Text('AR')),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.appName.translate,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
