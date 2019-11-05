import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud_with_rxdart/src/app.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}