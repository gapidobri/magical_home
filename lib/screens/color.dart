import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:magic_home/magic_home.dart';
import 'package:magical_home/utils/color.dart';
import 'dart:ui'
as flutter;

import '../navigation.dart';

class Color extends StatefulWidget {
  @override
  _ColorState createState() => _ColorState();
}

class _ColorState extends State < Color > {

  Light device = Navigation.selectedDevice;
  flutter.Color _pickerColor;

  @override
  Widget build(BuildContext context) {

    _pickerColor = toUIColor(device.color);

    TextEditingController _rController = TextEditingController(text: _pickerColor.red.toString());
    TextEditingController _gController = TextEditingController(text: _pickerColor.green.toString());
    TextEditingController _bController = TextEditingController(text: _pickerColor.blue.toString());

    void changeColor(flutter.Color color) {
      _pickerColor = color;
      _rController.text = color.red.toString();
      _gController.text = color.green.toString();
      _bController.text = color.blue.toString();
      device.setColor(fromUIColor(color));
    }
    
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          ColorPicker(
            pickerColor: _pickerColor,
            enableAlpha: false,
            showLabel: false,
            colorPickerWidth: MediaQuery.of(context).size.width,
            pickerAreaHeightPercent: .5,
            pickerAreaBorderRadius: BorderRadius.all(Radius.circular(15.0)),
            onColorChanged: changeColor,
          ),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _rController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "R",
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _gController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "G",
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _bController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "B",
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.check),
                mini: true,
                onPressed: () => setState(() => 
                changeColor(flutter.Color.fromRGBO(
                  int.parse(_rController.text),
                  int.parse(_gController.text),
                  int.parse(_bController.text),
                  1.0
                ))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}