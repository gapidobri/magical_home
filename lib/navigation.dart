import 'package:flutter/material.dart';
import 'package:magic_home/magic_home.dart' hide Color;

import 'screens/home.dart';
import 'screens/color.dart';
import 'screens/modes.dart';

class Navigation extends StatefulWidget {

  static Light selectedDevice;

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int _selected = 0;
  
  void selectDevice(Light _device) async {
    Navigation.selectedDevice = _device;
    await Navigation.selectedDevice.connect();
    setState(() {
      print(Navigation.selectedDevice);
    });
    
  }

  @override
  Widget build(BuildContext context) {

    List < Widget > screens = [
      Home(deviceSelected: selectDevice),
      Color(),
      Modes(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Magical Home"),
        actions: _selected == 0 ? null : [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigation.selectedDevice.setPower(
                  !Navigation.selectedDevice.power
                );
              },
              child: Icon(Icons.power_settings_new),
            ),
          ),
        ],
      ),
      body: Navigation.selectedDevice == null ? screens[0] : screens[_selected],
      bottomNavigationBar: Navigation.selectedDevice == null ? null :
      BottomNavigationBar(
        currentIndex: _selected,
        onTap: (i) {
          setState(() {
            _selected = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Color",
            icon: Icon(Icons.colorize),
          ),
          BottomNavigationBarItem(
            label: "Modes",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}