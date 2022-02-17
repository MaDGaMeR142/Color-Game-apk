import 'package:flutter/material.dart';

var dark = {"bggrad1": Color(0xFF000000), "bggrad2": Color(0xFF2d3436)};

var theme = dark;
var darkgrad = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Color(0xFF000000),
    Color(0xFF2d3436),
  ],
));

var MemarianiGrad = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Color(0xFF000000),
    Color(0xFF2d3436),
  ],
));

var gradient = darkgrad;
void changeTheme(var n) {
  if (n == 'dark') {
    gradient = darkgrad;
    theme = dark;
  } else if (n == 'memarian') {
    gradient = MemarianiGrad;
  }
}
