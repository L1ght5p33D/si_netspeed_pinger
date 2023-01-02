import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easyping/easyping.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

Size? gss = null;

 TextStyle config_title_style = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w900,
    letterSpacing: 1,
    fontFamily: 'MontserratSubrayada');
 TextStyle config_dom_style = TextStyle(
    fontSize: 26.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    fontFamily: 'MontserratSubrayada');

 TextStyle config_desc_style = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    fontFamily: 'MontserratSubrayada');

TextStyle app_title_style = TextStyle(
    fontSize: gss!.width * .06,
    fontWeight: FontWeight.w900,
    letterSpacing: 1,
    fontFamily: 'MontserratSubrayada');
BorderSide tborderside =
BorderSide(width: 1.0, color: Colors.white, style: BorderStyle.solid);

List<double> zero_result_history = [];
// set user agreed checkbox value outside of rebuild
bool? user_has_ever_agreed = false;
String custom_ping_host = "www.google.com";

void main() async {
  print("Flutter main init");
  runApp(NetSpeedApp());
}

class NetSpeedApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetSpeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white70,
      ),
      home: NetDiagConfig(),
      // NetDiagHome(),
    );
  }
}

class Speed_Timer_Img extends StatelessWidget {
  Speed_Timer_Img({this.time});
  final double? time;
  @override
  Widget build(BuildContext context) {
    String timer_to_display = "";
    int zl = zero_result_history.length;
    if (zl > 2){
      if (zero_result_history[zl-1] == 0.0
      ){
        return Container(child:Text("Make sure you are connected to the internet"));
      }
    }


    if (time! > 0.0 && time! < 67.0){
      timer_to_display = "assets/fast_trans_white.png";
    }
    else if (time! > 67.0 && time! < 133.0){
      timer_to_display = "assets/suff_trans_white.png";
    }
    else if (time! > 133.0){
      timer_to_display = "assets/slow_trans_white.png";
    }
    else{return Container();}

    return Container(width:gss!.width,
        height: gss!.height*.35,
        child: Image.asset(timer_to_display,
          fit: BoxFit.fitHeight,
        ));
  }
}

Future<double> _call_ping(String thost) async {
  print("Init ping" + thost);
  double ret_ping_time = await ping(thost);
  print("Done pinging google.com result ::: " + ret_ping_time.toString());
  zero_result_history.add(ret_ping_time);
  return ret_ping_time;
}


class NetDiagConfig extends StatefulWidget {
  _NetDiagConfigState createState() => _NetDiagConfigState();
}

class _NetDiagConfigState extends State<NetDiagConfig> {

bool term_agree = false;
bool show_other_host_input = false;
var dd_val= "Google";
String test_domain_string = "www.google.com";


  Widget build(BuildContext context) {
    if (gss == null) {
      gss = MediaQuery.of(context).size;
    }


    List<DropdownMenuItem> dditems = [
      DropdownMenuItem(value:"Google",child:Text("Google",style: config_dom_style,)),
      DropdownMenuItem(value:"Amazon",child:Text("Amazon",style: config_dom_style,)),
      DropdownMenuItem(value:"ATT",child:Text("ATT", style: config_dom_style,)),
      DropdownMenuItem(value:"Other Host",child:Text("Other Host", style: config_dom_style,)),
    ];

    if (custom_ping_host != test_domain_string) {
      test_domain_string = custom_ping_host;
    }

print("Test ping domain  ::: ");
    print(test_domain_string);

    if (test_domain_string == "www.google.com"){
        dd_val = "Google";
      }
        else if (test_domain_string == "www.amazon.com"){
        dd_val = "Amazon";
      }
          else if (test_domain_string == "www.att.com"){
        dd_val = "ATT";
      }
              else {
        dd_val = "Other Host";
      }

    term_agree = user_has_ever_agreed!;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:Center(child:Text("NetSpeed", style: config_title_style) ,
          )),
        body:Container(
          color: Colors.blueGrey[900],
      height: gss!.height*.97,
      child: Column(children: <Widget>[
        Container(
          color: Colors.blueGrey[900],
          height: gss!.height*.1,),
          ClipRRect(
            borderRadius: BorderRadius.circular(gss!.width*.02),
            child:
        Container(
          padding: EdgeInsets.fromLTRB(gss!.width*.03, gss!.width*.03, gss!.width*.03, gss!.width*.03),
            decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width:gss!.width*.01,style:BorderStyle.solid),),
            child:
        DropdownButton(
          value: dd_val,
          items: dditems,
          onChanged: (val){
            custom_ping_host = val;
            setState(() {
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
            if (val == "Other Host"){
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
        },)
        )),
        Container(
          color: Colors.blueGrey[900],
          height: gss!.height*.05,),

show_other_host_input == true?
Container(
  width: gss!.width *.76,
    decoration: BoxDecoration(border: Border.all(color: Colors.white,width:gss!.width*.01,style:BorderStyle.solid)),
    child:TextField(
      style: TextStyle(color: Colors.white),
  onSubmitted: (val){
        setState(() {
          test_domain_string = val;
          custom_ping_host = test_domain_string;
        });
   },
)):Container(child:Text(test_domain_string,style: config_desc_style,)),
        Container(height: gss!.height*.05,),

        GestureDetector(
            onTap:(){
              if (term_agree != true && user_has_ever_agreed == false){
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white54,
contentPadding: EdgeInsets.all(gss!.width*.01),
                      // title: Text('AlertDialog Title'),
                      content: Container(
                        color: Colors.blueGrey[900],
                        child:Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(padding:EdgeInsets.all(gss!.width*.02),
                            child:Column(children:[
                            Text('Please agree to the terms before running NetSpeed'),
                          Container(height: gss!.width*.04,),
                           GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                             child: ClipRRect(
                                 borderRadius: BorderRadius.circular(4.0),
                                 child:Container(
                                     padding: EdgeInsets.all(2.0),
                                     color:Colors.white,
                                     child:
                                     Container(
                                         color: Colors.blueGrey[800],
                                         height: gss!.height*.047,
                                         width: gss!.width * .3,
                                         child:Center(child: Text("Done"),))))
                            ),
                              ]))
                          ],
                        ),
                        ) ,
                    );
                  },
                );
              }else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      NetDiagHome(thost: test_domain_string,)),
                );
              }

        },child:
            ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child:Container(
          padding: EdgeInsets.all(2.0),
          color:Colors.white,
          child:
        Container(
          color: Colors.blueGrey[800],
          height: gss!.height*.09,
            width: gss!.width * .77,
            child:Center(child: Text("Start NetSpeed Test"),))))),
        Container(height: gss!.height*.05,),
        Container(
          // color: Colors.red,
            width: gss!.width * .9,
            child:
        Text("By clicking I agree, you agree to accept any liability that applies to making internet requests to the chosen host."
            )),
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

      ],),));
  }
}


class NetDiagHome extends StatefulWidget {
  NetDiagHome({Key? key, this.thost}) : super(key: key);
  final String? thost;
  _NetDiagHomeState createState() => _NetDiagHomeState();
}

class _NetDiagHomeState extends State<NetDiagHome> {

  bool show_menu = false;
  bool? ping_speed_test_running;

  @override
  void initState() {
    super.initState();
    ping_speed_test_running = false;
    start_recurse_single_ping_updater();
  }


  dispose(){
    super.dispose();
    print("NetDiagHome dispose");
  }

  double st_result = 0.0;

  int spt = 1;
  start_recurse_single_ping_updater() {
    run_single_ping_test(widget.thost);
    Future.delayed(Duration(seconds: 3), () {
      print("run single ping test no:: " + spt.toString());
      spt += 1;
      // run_single_ping_test();
    });
  }


  run_single_ping_test(thost) async {

    setState(() {
      ping_speed_test_running = true;
    });

    // keep list of ping results and end test running screen on result
    int ping_sample_size = 1;
    int ping_count = 0;
    double running_ping_time_count = 0;
    while (ping_count < ping_sample_size) {
      double cp_res = await _call_ping(thost);
      running_ping_time_count += cp_res;
      ping_count += 1;
    }

    double ping_time_avg = running_ping_time_count / ping_sample_size;
    setState(() {
      st_result = ping_time_avg;
      ping_speed_test_running = false;
    });
  }

  Widget build(BuildContext context) {
    if (gss == null) {
      gss = MediaQuery.of(context).size;
    }

return SafeArea(
        child:  Scaffold(body:Center(
              child:
              Container(
                height: gss!.height*1.2,
                  child:
                      Container(
                        color: ping_speed_test_running!? Colors.transparent:Colors.blueGrey[900],
                          width: gss!.width,
                          height: gss!.height * .95,
                          child: Stack(children: [
                            Container(
                                height: gss!.height*.94,
                                child:
                                Column(children:[

                                  ping_speed_test_running == true?
                                  Container(
                                      height: gss!.height*.94,
                                      child:
                                      Container(
                                          child:
                                          Image.asset(
                                            "assets/cloud_turtle_balloon_animation_reverse_scale.gif",
                                            fit: BoxFit.cover,
                                          ))):Container(),
                                ])),

                            Container(

                                height: gss!.height*.95,
                                width: gss!.width,
                                child:
                                Container(
                                    height: gss!.height*.94,

                                    child:
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                gss!.width*.1,
                                                0,
                                              0
                                            ),
                                            child:
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[

                                        (ping_speed_test_running == false &&
                                            st_result != 0.0
                                        )
                                            ? Container(
                                            child: Text(
                                              "Network Delay to host",
                                              style: config_desc_style,
                                            ))
                                            : Container(),
                                        (ping_speed_test_running == false &&
                                            st_result != 0.0
                                        )
                                            ?
                                        Container(
                                            child: Text(
                                              widget.thost!,
                                              style: config_desc_style,
                                            )):Container(),

                                        (ping_speed_test_running == false &&
                                            st_result != 0.0
                                        )
                                            ? Container()

                                            :  Container(
                                          // height: gss!.height*.38,
                                          width: gss!.width,
                                          child:Column(children:[
                                          Container(
                                            // height: gss!.height*.38,
                                            width: gss!.width,
                                            child:
                                            Center(child:Text("Running NetSpeed",
                                              style: TextStyle(color: Colors.black,
                                                  fontSize: gss!.width *.06,
                                                  fontWeight: FontWeight.w800
                                              ),)),
                                          ),
                                              Container(
                                          height: gss!.height*.38,
                                          width: gss!.width,
                                        child: Center(child:Text("Timing ping request to host " + widget.thost! + " ...",
                                          style: TextStyle(color: Colors.black,
                                          fontSize: gss!.width *.04,
                                            fontWeight: FontWeight.w500
                                          ),)),
                                        ),

                                        ])),
                                        Container(
                                            width: gss!.width * .77,
                                            child: Center(
                                                child: ping_speed_test_running == false
                                                    ? Text(
                                                  st_result.toString()+" ms" ??
                                                      "",
                                                  style: app_title_style,
                                                )
                                                    : Container())),
                                        ping_speed_test_running == false?
                                        Speed_Timer_Img(time: st_result):Container(),
                                        Container(height: gss!.width*.02,),
                                        ping_speed_test_running == false?
                                        Container(
                                          height: gss!.height*.4,
                                          color: Theme.of(context).canvasColor,
                                          child: Center(child:
                                          Column(mainAxisSize: MainAxisSize.min,
                                              children:[
                                              Center(child:
                                                        GestureDetector(
                                                          onTap: (){
                                                            run_single_ping_test(widget.thost);
                                                          },
                                                          child:
                                                    ClipRRect(
                                                        borderRadius: BorderRadius.circular(
                                                            gss!.width * .03
                                                        ),
                                                        child:
                                                        Container(
                                                            color:Colors.white,
                                                            padding: EdgeInsets.all(gss!.width*.005),
                                                            child:
                                                            ClipRRect(
                                                                borderRadius: BorderRadius.circular(
                                                                    gss!.width * .03
                                                                ),
                                                                child:
                                                                Container(
                                                                    color: Colors.blueGrey[900],
                                                                    padding: EdgeInsets.all(0.0),
                                                                    width:gss!.width * .76,
                                                                    height: gss!.width*.17,
                                                                    child:
                                                                    Center(child: Text("Run Again",
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontFamily: 'MontserratSubrayada'),
                                                                    ),
                                                                    )))))),
                                                    ),
                                        // ),
                                                Container(height: gss!.height*.03,),
                                                GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) =>NetDiagConfig()),
                                                      );
                                                    },
                                                    child:
                                                    ClipRRect(
                                                        borderRadius: BorderRadius.circular(
                                                            gss!.width * .03
                                                        ),
                                                        child:
                                                        Container(
                                                            color:Colors.white,
                                                            padding: EdgeInsets.all(gss!.width*.005),
                                                            child:
                                                            ClipRRect(
                                                                borderRadius: BorderRadius.circular(
                                                                    gss!.width * .03
                                                                ),
                                                                child:
                                                                Container(
                                                                    color: Colors.blueGrey[900],
                                                                    padding: EdgeInsets.all(0.0),
                                                                    width:gss!.width * .76,
                                                                    height: gss!.width*.17,
                                                                    child:
                                                                    Center(child: Text("Home",
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontFamily: 'MontserratSubrayada'),
                                                                    ),
                                                                    ))))))


                                              ]
                                          )


                                          ),):Container(),


                                      ],
                                    )))),
                            Container(
                              width: gss!.width,
                                height: gss!.height*.97,
                                child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(color: Colors.transparent),
                                Container(
                                  width: gss!.width,
                                  color: Colors.blueGrey[900],
                                  child:Center(child:
                                Text("SigmaInfinitus",
                                  style: TextStyle(fontFamily: 'MontserratSubrayada'),)))
                              ],))
                          ])),

                  ),
        )

        ));

  }
}
