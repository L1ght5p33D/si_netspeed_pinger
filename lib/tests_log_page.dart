import 'package:flutter/material.dart';
import 'package:netspeed_si/nsas.dart';
import 'package:netspeed_si/netspeed_globals.dart';
import 'package:netspeed_si/dialogs.dart';

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

  clear_log(){
    gstorage!.setItem("test_log.json", {});
    nsas!.test_log = {};
    nsas!.test_desc_log = {};
    asw!.update_logs_state();
    asw!.update_desc_logs_state();
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    asw = InheritedWrapper.of(context);
    nsas = asw!.state!;



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

                  show_delete_dialog(context, nsas!.app_brightness, clear_log);
                },
                child: Icon(Icons.delete_sweep_outlined),)

            ],)),
          body:Container(height: gss!.height,
              child: ListView.builder(
                  itemCount: nsas!.test_log.keys.length,
                  itemBuilder: (context, idx){

                    // reverse order real quick
                    idx = nsas!.test_log.keys.length - idx - 1;
                    return
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: gss!.width*.02),
                          child:
                          Container(
                              color:
                              nsas!.app_brightness == Brightness.dark?
                              Colors.blueGrey[800]: Colors.grey[200],
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



