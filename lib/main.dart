import 'package:flutter/material.dart';
import 'package:magical_home/navigation.dart';

void main() {
  runApp(MagicalHome());
}

class MagicalHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magical Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Navigation(),
    );
  }
}