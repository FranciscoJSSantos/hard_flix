import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Poppins',
);

const kLabelStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    height: 1.0);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.grey,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final ButtonStyle styledButtonLogin = ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    textStyle: const TextStyle(fontSize: 20),
    elevation: 5.0,
    padding: const EdgeInsets.all(20.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)));
