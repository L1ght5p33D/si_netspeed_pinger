import 'package:flutter/material.dart';
import 'package:netspeed_si/netspeed_styles.dart';
import 'package:netspeed_si/netspeed_globals.dart';

class Speed_Timer_Img extends StatelessWidget {
  Speed_Timer_Img({this.time});

  final time;

  @override
  Widget build(BuildContext context) {
    String timer_to_display = "";
    int zl = zero_result_history.length;
    if (zl > 2) {
      if (zero_result_history[zl - 1] == 0.0) {
        return Container(
            child: Text("Make sure you are connected to the internet"));
      }
    }

    if (time! > 0.0 && time! < 67.0) {
      timer_to_display = "assets/fast_trans_white.png";
    } else if (time! > 67.0 && time! < 133.0) {
      timer_to_display = "assets/suff_trans_white.png";
    } else if (time! > 133.0) {
      timer_to_display = "assets/slow_trans_white.png";
    } else {
      return Container();
    }

    return Container(
        width: gss!.width,
        height: gss!.height * .35,
        child: Image.asset(
          timer_to_display,
          fit: BoxFit.fitHeight,
        ));
  }
}