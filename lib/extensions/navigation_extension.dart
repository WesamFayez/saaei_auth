import 'package:flutter/material.dart';

void pushTo(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}

void pushAndReplace(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}

void pushAndRemoveAll(BuildContext context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (Route<dynamic> route) => false,
  );
}

void pop(BuildContext context) {
  Navigator.of(context).pop();
}
