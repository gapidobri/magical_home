import 'package:flutter/material.dart';
import 'package:magic_home/magic_home.dart';

import '../navigation.dart';

Map < int, String > presets = {
  PresetPattern.SevenColorsCrossFade: "Seven color cross fade",
  PresetPattern.RedGradualChange: "Red gradual change",
  PresetPattern.GreenGradualChange: "Green gradual change",
  PresetPattern.BlueGradualChange: "Blue gradual change",
  PresetPattern.YellowGradualChange: "Yellow gradual change",
  PresetPattern.CyanGradualChange: "Cyan gradual change",
  PresetPattern.PurpleGradualChange: "Purple gradual change",
  PresetPattern.WhiteGradualChange: "White gradual change",
  PresetPattern.RedGreenCrossFade: "Red green cross fade",
  PresetPattern.RedBlueCrossFade: "Red blue cross fade",
  PresetPattern.GreenBlueCrossFade: "Green blue cross fade",
  PresetPattern.SevenColorStrobeFlash: "Seven color strobe flash",
  PresetPattern.RedStrobeFlash: "Red strobe flash",
  PresetPattern.GreenStrobeFlash: "Green strobe flash",
  PresetPattern.BlueStrobeFlash: "Blue strobe flash",
  PresetPattern.YellowStrobeFlash: "Yellow strobe flash",
  PresetPattern.CyanStrobeFlash: "Cyan strobe flash",
  PresetPattern.PurpleStrobeFlash: "Purple strobe flash",
  PresetPattern.WhiteStrobeFlash: "White strobe flash",
  PresetPattern.SevenColorsJumping: "Seven colors jumping",
};

class Modes extends StatefulWidget {
  @override
  _ModesState createState() => _ModesState();
}

class _ModesState extends State < Modes > {

  Light device = Navigation.selectedDevice;
  List < int > presetList = presets.keys.toList();
  
  int ledPattern = PresetPattern.SevenColorsCrossFade;
  int ledSpeed = 100;

  void setPattern({ int pattern, int speed }) {
    if (pattern != null) ledPattern = pattern;
    if (speed != null) ledSpeed = speed;
    device.setPresetPattern(pattern ?? ledPattern, speed ?? ledSpeed);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: presetList.length,
              itemBuilder: (context, index) {
                String presetName = presets[presetList[index]];
                return GestureDetector(
                  onTap: () => setPattern(pattern: presetList[index]),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(presetName),
                    ),
                  ),
                );
              },
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: ledSpeed.toDouble(),
            label: ledSpeed.toString(),
            divisions: 100,
            onChanged: (value) => setState(() => ledSpeed = value.toInt()),
            onChangeEnd: (value) => setPattern(speed: value.toInt()),
          ),
        ],
      ),
    );
  }
}