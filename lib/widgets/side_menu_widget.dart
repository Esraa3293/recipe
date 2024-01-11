import 'package:flutter/material.dart';

class SideMenuWidget extends StatelessWidget {
  IconData? icon;
  String? title;
  Color? color;

  SideMenuWidget({this.icon, this.title, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
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
