import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/utils/toast_message_status.dart';

class ToastMessage extends StatelessWidget {
  final ToastMessageStatus toastMessageStatus;
  final String message;

  const ToastMessage(
      {this.toastMessageStatus = ToastMessageStatus.normal,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).r,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 3.r,
                blurRadius: 10.r,
                offset: const Offset(0, 5),
                color: Colors.black12,
              )
            ],
            borderRadius: BorderRadius.circular(15.r),
            color: toastMessageStatus == ToastMessageStatus.success
                ? Colors.green
                : toastMessageStatus == ToastMessageStatus.failed
                    ? Colors.red
                    : Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(15).r,
          child: Text(
            message,
            style: TextStyle(
                color: toastMessageStatus == ToastMessageStatus.normal
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18),
            textAlign: TextAlign.start,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
