import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  final Route route;
  final String text;

  const ButtonWidget(this.route, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, route);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsConst.primaryColor,
          minimumSize: Size(20.w, 50.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r))),
      child: Text(
        text,
        style: hellix16white().copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
