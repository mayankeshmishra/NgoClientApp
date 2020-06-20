import 'package:flutter/material.dart';

import './screens/mapping.dart';
import './screens/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MappingPage(auth:Auth(),),
    );
  }
}
