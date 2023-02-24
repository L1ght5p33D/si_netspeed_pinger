
import 'package:flutter/material.dart';
import 'package:netspeed_si/netspeed_globals.dart';

class AppState{
  var test_log;
  var test_desc_log;

  Brightness app_brightness = Brightness.dark;
  LoadingScreenOption loading_screen_option = LoadingScreenOption.normal;
}

class InheritedNSAS extends InheritedWidget {
  InheritedNSAS(
      {Key? key,
        required this.child,
        required this.data,
        required this.appstate})
      : super(key: key, child: child);

  final Widget child;
  final AppState? appstate;
  final InheritedWrapperState data;

  @override
  bool updateShouldNotify(InheritedNSAS oldWidget) {
    return true;
  }
}

class InheritedWrapper extends StatefulWidget {
  final Widget child;
  InheritedWrapper({Key? key, required this.child, this.appstate}) : super(key: key);

  AppState? appstate;

  static InheritedWrapperState of(BuildContext context, {bool build = true}) {
    return build
        ? context.dependOnInheritedWidgetOfExactType<InheritedNSAS>()!.data
        : context.findAncestorWidgetOfExactType<InheritedNSAS>()!.data;
  }

  @override
  InheritedWrapperState createState() => InheritedWrapperState();
}



class InheritedWrapperState extends State<InheritedWrapper> {

  void update_logs_state() {
    setState(() {
      state!.test_log;
    });
  }

  void update_desc_logs_state() {
    setState(() {
      state!.test_desc_log;
    });
  }

  void update_state(){
    setState(() {state!;});
  }

  AppState? state;

  @override
  void initState() {
    state = AppState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedNSAS(
        child: this.widget.child, data: this, appstate: state);
  }
}
