import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  String title;

  FormTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
