import 'package:flutter/material.dart';
import 'package:conference_app/pages/onboard.dart';
import 'package:conference_app/util/Singleton.dart';

void main() {
  Singleton session = Singleton.instance;
  session.setUsername('null');
  session.setUserID('0');
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'onboard',
        routes: {
          'onboard': (context) => const MyOnBoardScreen(),
        }),
  );
}
