import 'package:flutter/material.dart';
import 'package:netspeed_si/nsas.dart';
import 'package:netspeed_si/netspeed_styles.dart';
import 'package:localstorage/localstorage.dart';
import 'package:netspeed_si/netspeed_globals.dart';


class TestLogPage extends StatefulWidget {
  TestLogPage({Key? key}) : super(key: key);


  @override
  _TestLogPageState createState() => _TestLogPageState();
}

class _TestLogPageState extends State<TestLogPage> {
bool edit_logs = false;
bool show_edit = false;
int? edit_idx ;
String? input_desc_val;

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
                            nsas!.test_desc_log = {};
                            asw!.update_logs_state();
                            asw!.update_desc_logs_state();
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


    if (nsas!.test_log == null){
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              edit_logs = !edit_logs;
            });
          },
          child: edit_logs == false? Icon(Icons.edit_off ): Icon(Icons.close),),
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
                  itemCount: nsas!.test_log.keys.length,
                  itemBuilder: (context, idx){
                    return
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: gss!.width*.02),
                          child:
                          Container(
                              color: Colors.blueGrey[900],
                              height:
                              (edit_idx != idx &&
                                  nsas!.test_desc_log.containsKey(nsas!.test_log.keys.elementAt(idx)) )?
                              gss!.height*.2:
                              (edit_idx == idx &&
                                  nsas!.test_desc_log.containsKey(nsas!.test_log.keys.elementAt(idx)) )?
                                  gss!.height*.3:
                              (edit_idx == idx)?
                              gss!.height*.2:
                              gss!.height*.1,
                              child:
                                  Column(children:[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:[
                                    (edit_logs == true && idx != edit_idx)?
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          show_edit = true;
                                          edit_idx = idx;
                                        });

                                      },
                                    child:Icon(Icons.edit)):
                                    edit_idx == idx?
                                    GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            show_edit = false;
                                            edit_idx = null;
                                          });

                                          if (input_desc_val != null){
                                            print(input_desc_val);
                                            setState(() {
                                            nsas!.test_desc_log[nsas!.test_log.keys.elementAt(idx)]
                                            = input_desc_val;
                                            });
                                            storage.setItem('test_desc_log.json',nsas!.test_desc_log);
                                            asw!.update_desc_logs_state();

                                          }

                                        },
                                        child:Icon(Icons.check)):
                                    Container(),
                             Container(
                                 height: gss!.height*.1,
                                 child: Center(child:Text( "test " +(idx + 1).toString() +" ::: " +
                                  nsas!.test_log[nsas!.test_log.keys.elementAt(idx)].toString() + "ms" ) )),

                                    edit_logs == true?GestureDetector(
                                      onTap: (){
                                        nsas!.test_log.remove(nsas!.test_log.keys.elementAt(idx));
                                        gstorage!.setItem("test_log.json", nsas!.test_log);
                                        asw!.update_logs_state();
                                      },
                                    child:Icon(Icons.delete_outline_outlined)): Container()
                                  ]),

                                    nsas!.test_desc_log[nsas!.test_log.keys.elementAt(idx)] != null?
                                    Container(
                                        height: gss!.height*.1,
                                        child: Center(child:Text("Desc: " +
                                            nsas!.test_desc_log[nsas!.test_log.keys.elementAt(idx)].toString() ) )): Container(),

                                    edit_idx == idx?
                                    Container(
                                        height: gss!.height*.1,child:
                                    TextField(
                                      style: TextStyle(fontSize: gss!.width*.04),
                                      maxLength:(gss!.width/ (gss!.width*.04)).toInt(),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.tealAccent, width: gss!.width*.01),
                                        ),
                                      )
                                      ,
                                      onChanged: (String val){
                                        print("change");
                                        setState(() {
                                          input_desc_val = val;
                                        });

                                      },
                                    )):Container()

                                  ])
                    ));
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