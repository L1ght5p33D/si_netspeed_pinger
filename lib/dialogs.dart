
import 'package:flutter/material.dart';
import 'package:netspeed_si/netspeed_globals.dart';

show_hostempty_dialog(BuildContext context, Brightness app_brightness) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:
        app_brightness == Brightness.dark?
        Colors.white54: Colors.black,
        contentPadding: EdgeInsets.all(gss!.width * .01),
        // title: Text('AlertDialog Title'),
        content: Container(
            color: app_brightness== Brightness.dark? Colors.blueGrey[900]: Colors.white,
            padding: EdgeInsets.all(gss!.width * .04),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Please enter a hostname to test other host'),
                  Container(
                    height: gss!.width * .04,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(4.0),
                          child: Container(
                              padding: EdgeInsets.all(2.0),
                              color: app_brightness== Brightness.dark?
                              Colors.white: Colors.black,
                              child: Container(
                                  color:
                                  app_brightness== Brightness.dark?
                                  Colors.blueGrey[800]: Colors.white,
                                  height:
                                  gss!.height * .047,
                                  width: gss!.width * .3,
                                  child: Center(
                                    child: Text("Done",
                                    ),
                                  ))))),
                ])),
      );
    },
  );
}

show_terms_dialog(BuildContext context, Brightness app_brightness){
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white54,
        contentPadding: EdgeInsets.all(gss!.width * .01),
        // title: Text('AlertDialog Title'),
        content: Container(
            color: app_brightness== Brightness.dark? Colors.blueGrey[900]: Colors.white,
            padding: EdgeInsets.all(gss!.width * .04),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Please agree to the terms before running NetSpeed'),
                  Container(
                    height: gss!.width * .04,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(4.0),
                          child: Container(
                              padding: EdgeInsets.all(2.0),
                              color: app_brightness== Brightness.dark? Colors.white: Colors.black,
                              child: Container(
                                  color:app_brightness== Brightness.dark? Colors.blueGrey[900]: Colors.white,
                                  height:
                                  gss!.height * .047,
                                  width: gss!.width * .3,
                                  child: Center(
                                    child: Text("Done"),
                                  ))))),
                ])),
      );
    },
  );
}

show_delete_dialog(BuildContext context, Brightness app_brightness, clear_log) {
  showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white54,
        contentPadding: EdgeInsets.all(gss!.width * .01),
        // title: Text('AlertDialog Title'),
        content: Container(
            color: app_brightness== Brightness.dark? Colors.blueGrey[900]: Colors.white,
            padding: EdgeInsets.all(gss!.width * .04),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Are you sure you want to clear the test log?'),
                  Container(
                    height: gss!.width * .04,
                  ),
                  GestureDetector(
                      onTap: () {
clear_log();
                      },
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(4.0),
                          child: Container(
                              padding: EdgeInsets.all(2.0),
                              color:   app_brightness== Brightness.dark? Colors.white:Colors.black,
                              child: Container(
                                  color:
                               app_brightness== Brightness.dark? Colors.blueGrey[900]: Colors.white,
                                  height:
                                  gss!.height * .047,
                                  width: gss!.width * .3,
                                  child: Center(
                                    child: Text("Yes"),
                                  ))))),
                  Container(
                    height: gss!.height * .05,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(4.0),
                          child: Container(
                              padding: EdgeInsets.all(2.0),
                              color:   app_brightness== Brightness.dark? Colors.white:Colors.black,
                              child: Container(
                                  color:
                                  app_brightness== Brightness.dark? Colors.blueGrey[900]: Colors.white,
                                  height:
                                  gss!.height * .047,
                                  width: gss!.width * .3,
                                  child: Center(
                                    child: Text("No"),
                                  ))))),
                ])),
      );
    },
  );
}