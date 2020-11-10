import 'package:flutter/material.dart';
import 'package:magic_home/magic_home.dart' hide Color;
import 'package:shared_preferences/shared_preferences.dart';

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
  String _selectedName = "";
  
  void selectDevice(Light _device) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('selected', _device.address);

    Navigation.selectedDevice = _device;
    // ignore: await_only_futures
    await Navigation.selectedDevice.connect();
    setState(() {});
  }

  @override
  void initState() {
    SharedPreferences.getInstance()
    .then((storage) {
      if (storage.containsKey('selected'))
        Navigation.selectedDevice = Light(storage.getString('selected'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List < Widget > screens = [
      Home(deviceSelected: selectDevice),
      Color(),
      Modes(),
    ];

    SharedPreferences.getInstance().then((storage) {
      if (storage.containsKey(Navigation.selectedDevice.address))
        setState(() {
          _selectedName = storage.getString(Navigation.selectedDevice.address);
        });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedName),
        actions: _selected == null ? null : [
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
        onTap: (i) => setState(() => _selected = i),
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