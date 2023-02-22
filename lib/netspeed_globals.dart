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

List<DropdownMenuItem> dditems = [
  DropdownMenuItem(
      value: "Google DNS",
      child: Text(
        "Google",
        style: config_dom_style,
      )),
  DropdownMenuItem(
      value: "Cloudflare DNS",
      child: Text(
        "Cloudflare",
        style: config_dom_style,
      )),
  DropdownMenuItem(
      value: "ATT DNS",
      child: Text(
        "ATT",
        style: config_dom_style,
      )),
  DropdownMenuItem(
      value: "Other Host",
      child: Text(
        "Other Host",
        style: config_dom_style,
      )),
  DropdownMenuItem(
      value: "Multiple",
      child: Text(
        "",
        style: config_dom_style,
      )),
];