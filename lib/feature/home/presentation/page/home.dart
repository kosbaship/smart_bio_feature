import 'package:feature_oriented/core/utils/compass.dart';
import 'package:feature_oriented/feature/splash/one_scaffold/base_layout.dart';
import 'package:feature_oriented/feature/splash/one_scaffold/products.dart';
import 'package:feature_oriented/feature/splash/translaltion/translation_test.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String name;

  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(child: Text('Home')),
            ),
            ListTile(
              title: const Text('Open Translation Page'),
              onTap: () {
                navTo(context, const TranslationPageTest());
              },
            ),
            ListTile(
              title: const Text('Open Base Layout'),
              onTap: () {
                navTo(
                    context,
                    BaseLayout(
                      hasAppBar: true,
                      hasDrawer: true,
                      layoutBuilder: buildProducts(),
                    ));
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          const Text(
            'Hi',
            style: TextStyle(fontSize: 32),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 50),
          ),
        ],
      ),
    );
  }
}
