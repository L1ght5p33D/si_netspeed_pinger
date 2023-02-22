import 'package:flutter/material.dart';
import 'package:netspeed_si/netdiag_test.dart';
import 'package:netspeed_si/netspeed_styles.dart';
import 'package:netspeed_si/speedtimer.dart';
import 'package:netspeed_si/netdiag_config.dart';

class NetDiagResults extends StatefulWidget {
  NetDiagResults({Key? key, this.thost, this.st_result}) : super(key: key);

  //test host
  final String? thost;

  // result of speed test
  final st_result;

  _NetDiagResultsState createState() => _NetDiagResultsState();
}

class _NetDiagResultsState extends State<NetDiagResults> {
  dispose() {
    super.dispose();
    print("NetDiagResults dispose");
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Container(
                height: gss!.height,
                child: Container(
                    color: Colors.blueGrey[900],
                    width: gss!.width,
                    height: gss!.height * .95,
                    child: Stack(children: [
                      Container(
                          height: gss!.height * .95,
                          width: gss!.width,
                          child: Container(
                              height: gss!.height * .94,
                              child: Container(
                                  padding:
                                  EdgeInsets.fromLTRB(0, gss!.width * .1, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      widget.st_result != 0.0
                                          ? Column(children: [
                                        Container(
                                            child: Text(
                                              "Network Delay to host",
                                              style: config_desc_style,
                                            )),
                                        Container(
                                            child: Text(
                                              widget.thost!,
                                              style: config_desc_style,
                                            )),
                                        Container(
                                            width: gss!.width * .77,
                                            child: Center(
                                                child: Text(
                                                  widget.st_result.toString() +
                                                      " ms" ??
                                                      "",
                                                  style: app_title_style,
                                                ))),
                                        Speed_Timer_Img(time: widget.st_result),
                                      ])
                                          : Container(
                                          padding: EdgeInsets.fromLTRB(
                                              gss!.width * .04,
                                              0.0,
                                              gss!.width * .04,
                                              gss!.width * .02),
                                          child: Center(
                                              child: Text(
                                                  "Unable to ping. Make sure your device is connected to the internet and the chosen domain is functional."))),
                                      Container(
                                        height: gss!.width * .02,
                                      ),
                                      Container(
                                        height: gss!.height * .4,
                                        color: Theme.of(context).canvasColor,
                                        child: Center(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Center(
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          var set_multi = false;
                                                          if (widget.thost == "multiple") {
                                                            set_multi = true;
                                                          }
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    NetDiagTest(
                                                                      thost: widget.thost,
                                                                      run_multi: set_multi,
                                                                    )),
                                                          );
                                                        },
                                                        child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                gss!.width * .03),
                                                            child: Container(
                                                                color: Colors.white,
                                                                padding: EdgeInsets.all(
                                                                    gss!.width * .005),
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        gss!.width *
                                                                            .03),
                                                                    child: Container(
                                                                        color: Colors
                                                                            .blueGrey[900],
                                                                        padding:
                                                                        EdgeInsets.all(
                                                                            0.0),
                                                                        width: gss!.width *
                                                                            .76,
                                                                        height: gss!.width *
                                                                            .17,
                                                                        child: Center(
                                                                          child: Text(
                                                                            "Run Again",
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .white,
                                                                                fontFamily:
                                                                                'MontserratSubrayada'),
                                                                          ),
                                                                        )))))),
                                                  ),
                                                  // ),
                                                  Container(
                                                    height: gss!.height * .03,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NetDiagConfig()),
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              gss!.width * .03),
                                                          child: Container(
                                                              color: Colors.white,
                                                              padding: EdgeInsets.all(
                                                                  gss!.width * .005),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      gss!.width * .03),
                                                                  child: Container(
                                                                      color: Colors
                                                                          .blueGrey[900],
                                                                      padding:
                                                                      EdgeInsets.all(
                                                                          0.0),
                                                                      width:
                                                                      gss!.width * .76,
                                                                      height:
                                                                      gss!.width * .17,
                                                                      child: Center(
                                                                        child: Text(
                                                                          "Home",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontFamily:
                                                                              'MontserratSubrayada'),
                                                                        ),
                                                                      ))))))
                                                ])),
                                      )
                                    ],
                                  )))),
                      Container(
                          width: gss!.width,
                          height: gss!.height * .97,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(color: Colors.transparent),
                              Container(
                                  width: gss!.width,
                                  color: Colors.blueGrey[900],
                                  child: Center(
                                      child: Text(
                                        "SigmaInfinitus",
                                        style: TextStyle(fontFamily: 'MontserratSubrayada'),
                                      )))
                            ],
                          ))
                    ])),
              ),
            )));
  }
}