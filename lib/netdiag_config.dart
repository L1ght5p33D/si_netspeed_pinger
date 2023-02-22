import 'package:flutter/material.dart';
import 'package:netspeed_si/netspeed_styles.dart';
import 'package:netspeed_si/netspeed_globals.dart';
import 'package:netspeed_si/netdiag_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netspeed_si/nsas.dart';
import 'package:netspeed_si/tests_log.dart';



class NetDiagConfig extends StatefulWidget {
  _NetDiagConfigState createState() => _NetDiagConfigState();
}

class _NetDiagConfigState extends State<NetDiagConfig> {


  bool term_agree = false;
  bool show_other_host_input = false;
  var dd_val = "Google DNS";
  String test_domain_string = "8.8.8.8";
  bool run_multi = false;

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

  show_hostempty_dialog() {
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

  show_terms_dialog(){
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

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      storage.ready.then((res){
        setState(() {
          gstorage = storage;
          nsas!.test_log = storage.getItem('test_log.json');
        });
      });
    });
    super.initState();
  }

  InheritedWrapperState? asw;
  AppState? nsas;
  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;

    gss = MediaQuery.of(context).size;

    print("Test ping domain  ::: ");
    print(test_domain_string);

    if (test_domain_string == "8.8.8.8") {
      dd_val = "Google DNS";
    } else if (test_domain_string == "1.1.1.1") {
      dd_val = "Cloudflare DNS";
    } else if (test_domain_string == "12.127.16.68") {
      dd_val = "ATT DNS";
    } else if (test_domain_string == "multiple") {
      dd_val = "Multiple";
    } else if(run_multi != true && show_other_host_input == false) {
      dd_val = "Google DNS";
      test_domain_string = "8.8.8.8";
    }
    else if (show_other_host_input == true) {
      dd_val = "Other Host";
    }

    term_agree = user_has_ever_agreed!;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text("NetSpeed SI", style: config_title_style),
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: gss!.width*.04),
          color: Colors.blueGrey[900],
          height: gss!.height * .97,
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.blueGrey[900],
                height: gss!.height * .01,
              ),
              Container(
                height: gss!.height * .05,
              ),
              Container(
                // color: Colors.red,
                  width: gss!.width * .9,
                  child: Text(
                      "By clicking I agree, you agree to make internet requests to the chosen host.")),
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
              ),
              Container(
                color: Colors.blueGrey[900],
                height: gss!.height * .03,
              ),
              Test_History(),
              Container(
                color: Colors.blueGrey[900],
                height: gss!.height * .04,
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
                          setState(() {
                            run_multi = false;
                            show_other_host_input = false;

                            if (val == "Google DNS") {
                              test_domain_string = "8.8.8.8";
                            }
                            if (val == "Cloudflare DNS") {
                              test_domain_string = "1.1.1.1";
                            }
                            if (val == "ATT DNS") {
                              test_domain_string = "12.127.16.68";
                            }
                          });
                          if (val == "Other Host") {
                            setState(() {
                              show_other_host_input = true;
                              test_domain_string = "";
                            });
                          }
                          setState(() {
                            dd_val = val;
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
                        });
                      },
                      onChanged: (val){
                      setState(() {
                      test_domain_string = val;
                      });
                      },
                    ))
              ])
                  : Container(
                  child: Center(child:Text(
                    test_domain_string,
                    style: config_desc_style,
                  ))),
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
                      show_other_host_input = false;
                      dd_val = "Multiple";
                    });
                  }
                  if (run_multi == false) {
                    test_domain_string = dd_val;

                    if (dd_val == "Other Host") {
                      show_other_host_input = true;

                    }

                  }

                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              Container(
                height: gss!.height * .05,
              ),
              GestureDetector(
                  onTap: () {
                    if (term_agree == false && user_has_ever_agreed == false) {
                     show_terms_dialog();
                    }
                    else  if (dd_val == "Other Host" && test_domain_string == ""){
                      show_hostempty_dialog();
                    }
                    else {
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
                color: Colors.blueGrey[900],
                height: gss!.height * .1,
              ),

            ],
          ),
        ));
  }
}