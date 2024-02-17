import 'package:flutter/material.dart';

abstract class Navigation {
  static push({required BuildContext context, required Widget page}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
