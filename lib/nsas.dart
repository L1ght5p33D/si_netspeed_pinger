
import 'package:flutter/material.dart';

class AppState{
  var test_log;
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

  void update_logs_state(new_logs) {
    setState(() {
      state!.test_log = new_logs;
    });
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
