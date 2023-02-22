
import 'package:flutter/material.dart';
import 'package:netspeed_si/netspeed_globals.dart';

show_hostempty_dialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white54,
        contentPadding: EdgeInsets.all(gss!.width * .01),
        // title: Text('AlertDialog Title'),
        content: Container(
            color: Colors.blueGrey[900],
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
                              color: Colors.white,
                              child: Container(
                                  color:
                                  Colors.blueGrey[800],
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

show_terms_dialog(BuildContext context){
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white54,
        contentPadding: EdgeInsets.all(gss!.width * .01),
        // title: Text('AlertDialog Title'),
        content: Container(
            color: Colors.blueGrey[900],
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
                              color: Colors.white,
                              child: Container(
                                  color:
                                  Colors.blueGrey[800],
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