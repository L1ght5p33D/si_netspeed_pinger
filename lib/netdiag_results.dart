import 'package:flutter/material.dart';
import 'package:netspeed_si/netdiag_test.dart';
import 'package:netspeed_si/netspeed_styles.dart';
import 'package:netspeed_si/speedtimer.dart';
import 'package:netspeed_si/netdiag_config.dart';
import 'package:netspeed_si/netspeed_globals.dart';
import 'package:netspeed_si/nsas.dart';

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

  InheritedWrapperState? asw;
  AppState? nsas;
  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;
    String time_slug = DateTime.now().millisecondsSinceEpoch.toString();
    String time_slug_short = time_slug.substring(0, time_slug.length -4);
    Map test_table = gstorage!.getItem("test_log.json");

    if (test_table == null){
      test_table = {};
    }
    test_table["test_"+time_slug_short] = widget.thost! + " ::: " + widget.st_result.toString();
    gstorage!.setItem("test_log.json", test_table);

    String show_host = "";

    if (host_list.contains(widget.thost)){
      show_host = widget.thost.toString() + " " + host_name_list[host_list.indexOf(widget.thost)] ;
    }else{
      show_host = widget.thost!;
    }

    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Container(
                height: gss!.height,
                child: Container(
                    color:
                    Colors.blueGrey[900],
                    width: gss!.width,
                    height: gss!.height ,
                    child: Stack(children: [
                      Container(
                          height: gss!.height ,
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
                                              "Ping to ",
                                              style: config_desc_style,
                                            )),
                                        Container(
                                            child: Text(
                                              show_host,
                                              style: config_desc_style,
                                            )),
                                        Container(
                                            width: gss!.width * .77,
                                            child: Center(
                                                child: Text(
                                                  widget.st_result.toString() +
                                                      " ms" ??
                                                      "",
                                                  style: config_desc_style,
                                                ))),
                                        Container(height: gss!.height*.03,),
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

                                      Expanded(child:
                                      Container(
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
                                                                color:
                                                                nsas!.app_brightness == Brightness.dark?
                                                                Colors.white: Colors.black,
                                                                padding: EdgeInsets.all(
                                                                    gss!.width * .005),
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        gss!.width *
                                                                            .03),
                                                                    child: Container(
                                                                        color: nsas!.app_brightness == Brightness.dark?
                                                                        Colors.blueGrey[900]: Colors.white,
                                                                        padding:
                                                                        EdgeInsets.all(
                                                                            0.0),
                                                                        width: gss!.width *
                                                                            .76,
                                                                        height: gss!.height *
                                                                            .08,
                                                                        child: Center(
                                                                          child: Text(
                                                                            "Run Again",
                                                                            style: TextStyle(
                                                                                color: nsas!.app_brightness == Brightness.dark?Colors
                                                                                    .white: Colors.black,
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
                                                              color:nsas!.app_brightness == Brightness.dark?
                                                              Colors.white: Colors.black,
                                                              padding: EdgeInsets.all(
                                                                  gss!.width * .005),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      gss!.width * .03),
                                                                  child: Container(
                                                                      color: nsas!.app_brightness == Brightness.dark?
                                                                      Colors.blueGrey[900]: Colors.white,
                                                                      padding:
                                                                      EdgeInsets.all(
                                                                          0.0),
                                                                      width:
                                                                      gss!.width * .76,
                                                                      height: gss!.height *
                                                                          .08,
                                                                      child: Center(
                                                                        child: Text(
                                                                          "Home",
                                                                          style: TextStyle(
                                                                              color:nsas!.app_brightness == Brightness.dark? Colors
                                                                                  .white: Colors.black,
                                                                              fontFamily:
                                                                              'MontserratSubrayada'),
                                                                        ),
                                                                      ))))))
                                                ])),
                                      ))
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
                                        style: TextStyle(fontFamily: 'MontserratSubrayada',
                                        color: Colors.white),
                                      )))
                            ],
                          ))
                    ])),
              ),
            )));
  }
}