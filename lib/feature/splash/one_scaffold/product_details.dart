import 'package:flutter/material.dart';

Widget buildProductsDetails(int index) => SafeArea(
      child: Center(
          child: Text(
        index.toString(),
        style: const TextStyle(fontSize: 40),
      )),
    );
