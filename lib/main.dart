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
  InheritedWrapperState? asw;
  AppState? nsas;
  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;

    return MaterialApp(
      title: 'SI NetSpeed',
      theme: ThemeData(
        brightness: nsas!.app_brightness,
        scaffoldBackgroundColor: Colors.blueGrey[900]
      ),
      home: NetDiagConfig(),
    );
  }
}




