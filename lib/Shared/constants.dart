import 'dart:math';

import 'package:flutter/material.dart';

//TEXT STYLES
var scaffoldMessengerTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: Colors.white
);

var homePageTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

// FORM FIELDS / TEXT INPUT DECORATIONS
var textInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue[900],
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green[900],
      width: 2.0,
    ),
  ),
);

//ELEVATED BUTTONS SECTION
var elevatedButtonStyle = ElevatedButton.styleFrom(
  elevation: 10.0,
  primary: Colors.blue[900],
  padding: EdgeInsets.all(10.0),
  minimumSize: Size.fromHeight(50.0),
);

var elevatedButtonTextStyle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white);

//CALCULATE FILE SIZES
String formatBytes({int bytes, int toDecimalPlaces}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(toDecimalPlaces)) +
        ' ' +
        suffixes[i];
  }