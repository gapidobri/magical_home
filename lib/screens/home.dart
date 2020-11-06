import 'package:flutter/material.dart';
import 'package:magic_home/magic_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {

  Home({
    @required this.deviceSelected
  });
  final void Function(Light light) deviceSelected;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State < Home > {

  List < Light > devices;
  SharedPreferences storage;

  @override
  void initState() {
    loadDevices();
    super.initState();
  }

  Future loadDevices() async {
    List < Light > _devices = await Light.discover();
    storage = await SharedPreferences.getInstance();
    setState(() {
      devices = _devices;
    });

    if (devices.length != 0) widget.deviceSelected(devices[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: loadDevices,
        child: devices == null ?
        Center(
          child: CircularProgressIndicator(),
        ) :
        ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            Light device = devices[index];
            return Card(
              margin: EdgeInsets.all(15.0),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 30.0,
                        ),
                        SizedBox(width: 10),
                        Text(
                          storage.getString(device.address) ?? "LED Strip",
                          style : TextStyle(
                            fontSize: 24.0
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController _renameController = TextEditingController(
                                  text: storage.getString(device.address) ?? "LED Strip"
                                );

                                return AlertDialog(
                                  title: Text("Rename"),
                                  content: TextField(
                                    controller: _renameController,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          storage.setString(device.address, _renameController.text);
                                        });
                                      },
                                      child: Text("Rename"),
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                          child: Icon(Icons.edit),
                        ),

                      ]
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }
}