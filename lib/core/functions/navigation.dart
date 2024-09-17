import 'package:flutter/material.dart';

void back(BuildContext context) {
  back(context);
}

void pushNamed(BuildContext context, String screen) {
  Navigator.of(context).pushNamed(screen);
}

void pushNamedReplacment(BuildContext context, String screen) {
  Navigator.of(context).pushReplacementNamed(screen);
}

void pushNamedAndRemoveUntil(BuildContext context, String screen, bool state) {
  Navigator.of(context).pushNamedAndRemoveUntil(screen, (route) => state);
}

void push(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

void pushReplacment(BuildContext context, Widget screen) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => screen));
}

void pushAndRemoveUntil(BuildContext context, Widget screen, bool state) {
  Navigator.of(context)
      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (route) => state);
}
