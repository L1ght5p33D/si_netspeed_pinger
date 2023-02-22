import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netspeed_si/netdiag_config.dart';
import 'package:netspeed_si/nsas.dart';

void main() async {
  print("Flutter main init");
  runApp(InheritedWrapper(child:NetSpeedApp()));

}

class NetSpeedApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI NetSpeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white70,
      ),
      home: NetDiagConfig(),
    );
  }
}




