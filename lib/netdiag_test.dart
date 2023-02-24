import 'package:flutter/material.dart';
import 'package:easyping/easyping.dart';
import 'package:netspeed_si/netspeed_globals.dart';
import 'package:netspeed_si/netdiag_results.dart';
import 'package:netspeed_si/nsas.dart';

class NetDiagTest extends StatefulWidget {
  NetDiagTest({Key? key, this.thost, this.run_multi}) : super(key: key);
  String? thost;
  final bool? run_multi;

  _NetDiagTestState createState() => _NetDiagTestState();
}

class _NetDiagTestState extends State<NetDiagTest> {

  bool init_ping = false;
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
    setState(() {
      init_ping = true;
    });
    await ping(thost).then((ping_res) async {
      print("ping resp ~ " + ping_res.toString());
      setState(() {
        init_ping = false;
      });
      await Future.delayed(Duration(milliseconds: 1000), () {
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

  InheritedWrapperState? asw;
  AppState? nsas;
  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;

    String show_host = "";

    if (host_list.contains(widget.thost)){
      show_host = widget.thost.toString() + " ... " + host_name_list[host_list.indexOf(widget.thost)] ;
    }else{
      show_host = widget.thost!;
    }
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
                                    child:
                                        nsas!.loading_screen_option == LoadingScreenOption.normal?
                                          Center(child:CircularProgressIndicator()):
                                    Image.asset(
                                      "assets/cloud_turtle_balloon_animation_reverse_scale.gif",
                                      fit: BoxFit.cover,
                                    )
                                )
                            ),
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
                                                    init_ping == true?"Opening ping ...":
                                                    "Timing ping to host " + show_host,
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