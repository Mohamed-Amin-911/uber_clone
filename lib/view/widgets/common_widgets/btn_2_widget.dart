import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/text_style.dart';

class Btn2Widget extends StatelessWidget {
  const Btn2Widget({
    super.key,
    required this.bgColor,
    required this.title,
    required this.function,
  });
  final Color bgColor;
  final String title;
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
        child: Text(
          title,
          style: appStyle(
              size: 17.sp,
              color: Kcolor.whiteColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
