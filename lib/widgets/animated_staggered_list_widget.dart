import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedStaggeredList extends StatefulWidget {
  final Widget widget;
  final int index;

  const AnimatedStaggeredList(
      {required this.widget, required this.index, super.key});

  @override
  State<AnimatedStaggeredList> createState() => _AnimatedStaggeredListState();
}

class _AnimatedStaggeredListState extends State<AnimatedStaggeredList> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: widget.index,
        delay: const Duration(milliseconds: 100),
        child: SlideAnimation(
            duration: const Duration(milliseconds: 2500),
            curve: Curves.fastLinearToSlowEaseIn,
            verticalOffset: -250.h,
            child: ScaleAnimation(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: widget.widget)));
  }
}
