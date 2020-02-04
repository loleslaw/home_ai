import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

// konieczny import flushbar: w pubspec.yaml

enum MessageType { ERROR, MESSAGE, WARNING, OK }

void showBottomMessage({MessageType type, BuildContext context, String title, String message}) {

    LinearGradient errorGradient = LinearGradient(
        colors: [Colors.red.shade800, Colors.redAccent.shade700],
        stops: [0.6, 1],
      );
    LinearGradient messageGradient = LinearGradient(
        colors: [Colors.blueGrey, Colors.grey.shade700],
        stops: [0.6, 1],
      );
    LinearGradient warningGradient = LinearGradient(
        colors: [Colors.yellow.shade800, Colors.yellowAccent.shade700],
        stops: [0.6, 1],
      );
    LinearGradient okGradient = LinearGradient(
        colors: [Colors.green.shade800, Colors.greenAccent.shade700],
        stops: [0.6, 1],
      );
    LinearGradient gradient;

    switch (type) {
      case MessageType.ERROR:
        gradient = errorGradient;
        break;
      case MessageType.MESSAGE:
        gradient = messageGradient;
        break;
      case MessageType.OK:
        gradient = okGradient;
        break;
      case MessageType.WARNING:
        gradient = warningGradient;
        break;
      default:
        gradient = messageGradient;
    }
     Flushbar(
     // aroundPadding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: gradient,
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      duration: type == MessageType.ERROR 
        ? Duration(seconds: 5)
        : Duration(seconds: 3),
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: title,
      message: message,
      icon: Icon( Icons.ac_unit, size: 30, color: Colors.white,),
    )..show(context);
  }