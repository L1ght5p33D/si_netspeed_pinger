import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:easyping/easyping.dart';
import 'package:si_netspeed/netspeed_styles.dart';
import 'package:si_netspeed/netspeed_globals.dart';

void main() async {
  print("Flutter main init");
  runApp(NetSpeedApp());
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

class NetDiagConfig extends StatefulWidget {
  _NetDiagConfigState createState() => _NetDiagConfigState();
}

class _NetDiagConfigState extends State<NetDiagConfig> {
  bool term_agree = false;
  bool show_other_host_input = false;
  var dd_val = "Google";
  String test_domain_string = "www.google.com";
  bool run_multi = false;

  List<DropdownMenuItem> dditems = [
    DropdownMenuItem(
        value: "Google",
        child: Text(
          "Google",
          style: config_dom_style,
        )),
    DropdownMenuItem(
        value: "Amazon",
        child: Text(
          "Amazon",
          style: config_dom_style,
        )),
    DropdownMenuItem(
        value: "ATT",
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

  Widget build(BuildContext context) {
    gss = MediaQuery.of(context).size;
    if (custom_ping_host != test_domain_string) {
      test_domain_string = custom_ping_host;
    }

    print("Test ping domain  ::: ");
    print(test_domain_string);

    if (test_domain_string == "www.google.com") {
      dd_val = "Google";
    } else if (test_domain_string == "www.amazon.com") {
      dd_val = "Amazon";
    } else if (test_domain_string == "www.att.com") {
      dd_val = "ATT";
    } else if (test_domain_string == "multiple") {
      dd_val = "Multiple";
    } else {
      dd_val = "Other Host";
    }

    term_agree = user_has_ever_agreed!;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text("NetSpeed", style: config_title_style),
            )),
        body: Container(
          color: Colors.blueGrey[900],
          height: gss!.height * .97,
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.blueGrey[900],
                height: gss!.height * .1,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(gss!.width * .02),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(gss!.width * .03,
                          gss!.width * .03, gss!.width * .03, gss!.width * .03),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: gss!.width * .01,
                            style: BorderStyle.solid),
                      ),
                      child: DropdownButton(
                        value: dd_val,
                        items: dditems,
                        onChanged: (val) {
                          custom_ping_host = val;
                          setState(() {
                            run_multi = false;
                            show_other_host_input = false;

                            if (val == "Google") {
                              test_domain_string = "www.google.com";
                            }
                            if (val == "Amazon") {
                              test_domain_string = "www.amazon.com";
                            }
                            if (val == "ATT") {
                              test_domain_string = "www.att.com";
                            }
                          });
                          if (val == "Other Host") {
                            setState(() {
                              show_other_host_input = true;
                              custom_ping_host = "";
                              test_domain_string = "";
                            });
                          }
                          setState(() {
                            dd_val = val;
                            custom_ping_host = test_domain_string;
                          });
                        },
                      ))),
              Container(
                color: Colors.blueGrey[900],
                height: gss!.height * .05,
              ),
              show_other_host_input == true
                  ? Column(children: [
                      Container(
                        color: Colors.blueGrey[900],
                        height: gss!.height * .05,
                        child: Center(child: Text("Enter domain to ping")),
                      ),
                      Container(
                          width: gss!.width * .76,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: gss!.width * .01,
                                  style: BorderStyle.solid)),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            onSubmitted: (val) {
                              setState(() {
                                test_domain_string = val;
                                custom_ping_host = test_domain_string;
                              });
                            },
                          ))
                    ])
                  : Container(
                      child: Text(
                      test_domain_string,
                      style: config_desc_style,
                    )),
              Container(
                height: gss!.height * .05,
              ),
              CheckboxListTile(
                title: Text("Run multi ping test"),
                value: run_multi,
                onChanged: (newValue) {
                  setState(() {
                    run_multi = !run_multi;
                  });
                  if (run_multi == true) {
                    setState(() {
                      test_domain_string = "multiple";
                      custom_ping_host = "multiple";
                      show_other_host_input = false;
                      dd_val = "Multiple";
                    });
                  }
                  if (run_multi == false) {
                    test_domain_string = dd_val;
                    if (dd_val != "Other Host") {
                      custom_ping_host = dd_val;
                    }
                    if (dd_val == "Other Host") {
                      show_other_host_input = true;
                    }
                  }
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              GestureDetector(
                  onTap: () {
                    if (term_agree != true && user_has_ever_agreed == false) {
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
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NetDiagTest(
                                  thost: test_domain_string,
                                  run_multi: run_multi,
                                )),
                      );
                    }
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Container(
                          padding: EdgeInsets.all(2.0),
                          color: Colors.white,
                          child: Container(
                              color: Colors.blueGrey[800],
                              height: gss!.height * .09,
                              width: gss!.width * .77,
                              child: Center(
                                child: Text("Start NetSpeed Test"),
                              ))))),
              Container(
                height: gss!.height * .05,
              ),
              Container(
                  // color: Colors.red,
                  width: gss!.width * .9,
                  child: Text(
                      "By clicking I agree, you agree to accept any liability that applies to making internet requests to the chosen host.")),
              CheckboxListTile(
                title: Text("Agree"),
                value: term_agree,
                onChanged: (newValue) {
                  user_has_ever_agreed = newValue;
                  setState(() {
                    term_agree = !term_agree;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              )
            ],
          ),
        ));
  }
}

class NetDiagTest extends StatefulWidget {
  NetDiagTest({Key? key, this.thost, this.run_multi}) : super(key: key);
  String? thost;
  final bool? run_multi;

  _NetDiagTestState createState() => _NetDiagTestState();
}

class _NetDiagTestState extends State<NetDiagTest> {
  List host_list = ["www.google.com", "www.amazon.com", "www.att.com"];
  List cached_ping_resps = [];

  @override
  void initState() {
    super.initState();
    print("NetDiagTest init");
    if (widget.run_multi == false) {
      _call_ping_and_push_results(widget.thost!, context);
    }
    if (widget.run_multi == true) {
      run_multi_ping_test(context);
    }
  }

  dispose() {
    super.dispose();
    print("NetDiagTest dispose");
  }

  _call_ping_and_push_results(String thost, BuildContext context) async {
    print("Init ping ~ " + thost);
    await ping(thost).then((ping_res) async {
      await Future.delayed(Duration(milliseconds: 1500), () {
        print("Ping result ::: " + ping_res.toString());
        zero_result_history.add(ping_res);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NetDiagResults(
                      st_result: ping_res,
                      thost: thost,
                    )));
      });
    });
  }

  _call_ping(String thost) async {
    print("Init ping ~ " + thost);
    await Future.delayed(Duration(seconds: host_list.indexOf(thost)), () async {
      setState(() {
        widget.thost = thost;
      });
      await ping(thost).then((ping_res) async {
        cached_ping_resps.add(ping_res);
        print("Ping result ::: " + ping_res.toString());
        print("all pings complete resps ~ " + cached_ping_resps.toString());
        if (cached_ping_resps.length == host_list.length) {
          int ping_res_round = ((cached_ping_resps[0] +
                      cached_ping_resps[1] +
                      cached_ping_resps[2]) /
                  3)
              .round();
          print("calculated ping res ~ " + ping_res_round.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NetDiagResults(
                        st_result: ping_res_round,
                        thost: "multiple",
                      )));
        }
      });
    });
  }

  run_multi_ping_test(BuildContext context) async {
    print("run multi ping test called");
    host_list.forEach((th) async {
      await _call_ping(th);
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Container(
        height: gss!.height * 1.2,
        child: Container(
            color: Colors.transparent,
            width: gss!.width,
            height: gss!.height * .95,
            child: Stack(children: [
              Container(
                  height: gss!.height * .94,
                  child: Column(children: [
                    Container(
                        height: gss!.height * .94,
                        child: Container(
                            child: Image.asset(
                          "assets/cloud_turtle_balloon_animation_reverse_scale.gif",
                          fit: BoxFit.cover,
                        ))),
                  ])),
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
                              Container(),
                              Container(
                                  // height: gss!.height*.38,
                                  width: gss!.width,
                                  child: Column(children: [
                                    Container(
                                      // height: gss!.height*.38,
                                      width: gss!.width,
                                      child: Center(
                                          child: Text(
                                        "Running NetSpeed",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: gss!.width * .06,
                                            fontWeight: FontWeight.w800),
                                      )),
                                    ),
                                    Container(
                                      height: gss!.height * .38,
                                      width: gss!.width,
                                      child: Center(
                                          child: Text(
                                        "Timing ping request to host " +
                                            widget.thost! +
                                            " ...",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: gss!.width * .04,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  ])),
                              Container(
                                height: gss!.width * .02,
                              ),
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

class Speed_Timer_Img extends StatelessWidget {
  Speed_Timer_Img({this.time});

  final time;

  @override
  Widget build(BuildContext context) {
    String timer_to_display = "";
    int zl = zero_result_history.length;
    if (zl > 2) {
      if (zero_result_history[zl - 1] == 0.0) {
        return Container(
            child: Text("Make sure you are connected to the internet"));
      }
    }

    if (time! > 0.0 && time! < 67.0) {
      timer_to_display = "assets/fast_trans_white.png";
    } else if (time! > 67.0 && time! < 133.0) {
      timer_to_display = "assets/suff_trans_white.png";
    } else if (time! > 133.0) {
      timer_to_display = "assets/slow_trans_white.png";
    } else {
      return Container();
    }

    return Container(
        width: gss!.width,
        height: gss!.height * .35,
        child: Image.asset(
          timer_to_display,
          fit: BoxFit.fitHeight,
        ));
  }
}
