import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget MainAppBar({String tekst})  {

  return AppBar(
      title: Text(tekst),
      centerTitle: true,
      elevation: defaultTargetPlatform == TargetPlatform.android ? 5 : 0,
    );
  }