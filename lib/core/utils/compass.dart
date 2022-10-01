import 'dart:io';

import 'package:flutter/material.dart';

getOS() => Platform.operatingSystem;

navTo(context, screen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

navBack(context) => Navigator.pop(context);

navAndFinish(context, screen) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (Route<dynamic> route) => false,
    );

navReplaceMe(context, screen) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
