import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String routeName;
  String text;

  ButtonWidget(this.routeName, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          minimumSize: const Size(20, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
