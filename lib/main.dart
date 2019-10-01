import 'package:card_flip_carousel/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
