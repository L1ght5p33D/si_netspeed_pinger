import 'package:flutter/material.dart';
import 'package:netspeed_si/netspeed_globals.dart';
import 'package:netspeed_si/nsas.dart';

class NetDiag_Settings extends StatefulWidget {
  const NetDiag_Settings({Key? key}) : super(key: key);

  @override
  _NetDiag_SettingsState createState() => _NetDiag_SettingsState();
}

class _NetDiag_SettingsState extends State<NetDiag_Settings> {

  bool theme_switch_val = true;
  var ps_dd_val = LoadingScreenOption.normal;

  List<DropdownMenuItem> ps_dd_items = [
    DropdownMenuItem(child: Text("Normal"), value: LoadingScreenOption.normal,),
    DropdownMenuItem(child: Text("Turtle"), value: LoadingScreenOption.turtle)

  ];
  InheritedWrapperState? asw;
  AppState? nsas;
  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;
    if (nsas!.app_brightness == Brightness.light){
      theme_switch_val = false;
    }
      ps_dd_val = nsas!.loading_screen_option;


    return SafeArea(child: Scaffold(
      appBar: AppBar(title:Text("Settings")),
        body:Container(

        height: gss!.height,
      child: ListView(children: [
        SwitchListTile(
          value: theme_switch_val,
            onChanged: (bool val){
              setState(() {
                theme_switch_val = val;
              });
              if (val == false) {
                nsas!.app_brightness = Brightness.light;
              }
              if (val == true) {
                nsas!.app_brightness = Brightness.dark;
              }
              asw!.update_state();
            },
            title:
        Row(children: [
          Text("Dark Mode")
        ],)
        ),

        ListTile(title:
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Ping loading screen"),
        DropdownButton(items: ps_dd_items,
            value: ps_dd_val,
            onChanged: (val){
            setState(() {
              ps_dd_val = val;
            });
            nsas!.loading_screen_option = val;
        })
        ])
        )
      ],),
      )
    ));
  }
}
