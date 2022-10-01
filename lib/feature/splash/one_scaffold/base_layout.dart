import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  late final Widget layoutBuilder;
  late final bool hasAppBar;
  late final bool hasDrawer;

  BaseLayout({
    Key? key,
    required this.hasAppBar,
    required this.hasDrawer,
    required this.layoutBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: hasAppBar ? _buildAppBar() : null,
        body: layoutBuilder,
        drawer: hasDrawer ? _buildDrawer() : null,
      );

  _buildDrawer() => const Drawer();

  _buildAppBar() => AppBar(
        title: Text(runtimeType.toString()),
      );
}
