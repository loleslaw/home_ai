import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _showCircularProgressBar(bool isLoading) {
  if (isLoading) {
    return Center(child: CircularProgressIndicator(),);
  }
  return Container(height: 0, width: 0,);
}