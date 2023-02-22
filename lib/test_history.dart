import 'package:flutter/material.dart';
import 'package:netspeed_si/nsas.dart';
import 'package:netspeed_si/netspeed_globals.dart';
import 'package:netspeed_si/tests_log_page.dart';

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
                builder: (context) => TestLogPage()),
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
