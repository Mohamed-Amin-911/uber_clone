import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Btn1Widget extends StatelessWidget {
  const Btn1Widget({
    super.key,
    required this.bgColor,
    required this.title,
    required this.function,
  });
  final Color bgColor;
  final Widget title;
  final void Function() function;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r))),
        child: title,
      ),
    );
  }
}
