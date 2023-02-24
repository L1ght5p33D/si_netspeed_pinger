import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:netspeed_si/netspeed_styles.dart';

Size? gss = Size(0,0);
List<double> zero_result_history = [];
// set user agreed checkbox value outside of rebuild
bool? user_has_ever_agreed = false;
// Google DNS, Cloudflare DNS , ATT DNS
List host_list = ["8.8.8.8", "1.1.1.1", "12.127.16.68"];

List host_name_list = ["Google DNS", "Cloudflare DNS", "AT&T DNS"];

final LocalStorage storage = new LocalStorage('test_log.json');
LocalStorage? gstorage;

enum LoadingScreenOption {
  normal,
  turtle
}

List<DropdownMenuItem> dditems(app_brightness) {
  TextStyle ddts = config_dom_style;
  if (app_brightness == Brightness.dark){
    ddts = config_dom_style_dark;
  }

  return [
    DropdownMenuItem(
        value: "Google DNS",
        child: Text(
          "Google",
          style: ddts,
        )),
    DropdownMenuItem(
        value: "Cloudflare DNS",
        child: Text(
          "Cloudflare",
          style: ddts,
        )),
    DropdownMenuItem(
        value: "ATT DNS",
        child: Text(
          "ATT",
          style: ddts,
        )),
    DropdownMenuItem(
        value: "Other Host",
        child: Text(
          "Other Host",
          style: ddts,
        )),
    DropdownMenuItem(
        value: "Multiple",
        child: Text(
          "",
          style: ddts,
        )),
  ];
}