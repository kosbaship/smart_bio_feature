import 'package:feature_oriented/core/utils/compass.dart';
import 'package:feature_oriented/feature/splash/one_scaffold/product_details.dart';
import 'package:flutter/material.dart';

import 'base_layout.dart';

Widget buildProducts() => ListView.builder(
    itemCount: 7, itemBuilder: (context, index) => _buildRow(context, index));

_buildRow(BuildContext context, int index) {
  return ListTile(
    title: Text("Item " + index.toString()),
    onTap: () => navTo(
        context,
        BaseLayout(
            hasAppBar: true,
            hasDrawer: false,
            layoutBuilder: buildProductsDetails(index))),
  );
}
