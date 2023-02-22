import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netspeed_si/nsas.dart';
import 'package:netspeed_si/netspeed_styles.dart';
import 'package:localstorage/localstorage.dart';
import 'package:netspeed_si/netspeed_globals.dart';


class TestLogPage extends StatefulWidget {
  TestLogPage({Key? key, required this.tests}) : super(key: key);

  Map tests;
  @override
  _TestLogPageState createState() => _TestLogPageState();
}

class _TestLogPageState extends State<TestLogPage> {

  InheritedWrapperState? asw;
  AppState? nsas;
  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;

    show_delete_dialog() {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
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
                          'Are you sure you want to clear the test log?'),
                      Container(
                        height: gss!.width * .04,
                      ),
                      GestureDetector(
                          onTap: () {
                            gstorage!.setItem("test_log.json", {});
                            nsas!.test_log = {};
                            asw!.update_state();
                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
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
                                  color: Colors.white,
                                  child: Container(
                                      color:
                                      Colors.blueGrey[800],
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
    if (widget.tests == null){
      return SafeArea(child:
      Scaffold(
          appBar: AppBar(),
          body: Padding(
              padding: EdgeInsets.symmetric(vertical: gss!.width*.02),
              child:
              Container(
                  color: Colors.blueGrey[900],
                  height: gss!.height*.1,
                  child:Center(child:Text( "No Tests Run" ) )))));
    }
    else {
      return  SafeArea(child:
      Scaffold(
          appBar: AppBar(title:Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  show_delete_dialog();
                },
                child: Icon(Icons.delete_sweep_outlined),)

            ],)),
          body:Container(height: gss!.height,
              child: ListView.builder(
                  itemCount: widget.tests.keys.length,
                  itemBuilder: (context, idx){
                    return
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: gss!.width*.02),
                          child:
                          Container(
                              color: Colors.blueGrey[900],
                              height: gss!.height*.1,
                              child:Center(child:Text( "test " +(idx + 1).toString() +" ::: " +
                                  widget.tests[widget.tests.keys.elementAt(idx)].toString() + "ms" ) )));
                  }))));
    }
  }
}

class Test_History extends StatefulWidget {
  const Test_History({Key? key}) : super(key: key);

  @override
  _Test_HistoryState createState() => _Test_HistoryState();
}

class _Test_HistoryState extends State<Test_History> {

  InheritedWrapperState? asw;
  AppState? nsas;

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

  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;

return GestureDetector(
onTap:(){
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => TestLogPage(tests: nsas!.test_log)),
);
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
child: Text("Test Log"),
)))));
  }
}

// return FutureBuilder(
// future: storage.ready,
// builder: (BuildContext context, snapshot) {
// gstorage = storage;
//
// if (snapshot.data == true) {
// var data = storage.getItem('test_log.json');
// print("got tests ~ " + data.toString());
// return
// GestureDetector(
// onTap:(){
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => TestLogPage(tests: data)),
// );
// },
// child: ClipRRect(
// borderRadius: BorderRadius.circular(4.0),
// child: Container(
// padding: EdgeInsets.all(2.0),
// color: Colors.white,
// child: Container(
// color: Colors.blueGrey[800],
// height: gss!.height * .09,
// width: gss!.width * .77,
// child: Center(
// child: Text("Test Log"),
// )))));
//
// } else {
// return Container();
// }
// },
// );