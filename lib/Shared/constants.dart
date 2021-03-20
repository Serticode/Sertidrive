import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sertidrive/Shared/clipper.dart';

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

//CLIPPER
Widget curve() {
    return Container(
        child: Stack(
      children: <Widget>[
        //stack overlaps widgets
        Opacity(
          //semi red clipPath with more height and with 0.5 opacity
          opacity: 0.5,
          child: ClipPath(
            clipper: WaveClipper(), //set our custom wave clipper
            child: Container(
              color: Colors.blue[900],
              height: 100,
            ),
          ),
        ),

        ClipPath(
          //upper clipPath with less height
          clipper: WaveClipper(), //set our custom wave clipper.
          child: Container(
            color: Colors.blue[800],
            height: 90,
            alignment: Alignment.center,
          ),
        ),
      ],
    ));
  }