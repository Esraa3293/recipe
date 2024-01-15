import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  IconData? icon;
  String? title;
  Color? color;

  SideMenuItem({this.icon, this.title, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.04),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
