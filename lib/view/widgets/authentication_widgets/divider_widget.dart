import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/text_style.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: Kcolor.darkGreyColor,
          ),
        ),
        Text(
          "  or  ",
          style: appStyle(
              size: 17.sp,
              color: Kcolor.darkGreyColor,
              fontWeight: FontWeight.w500),
        ),
        const Expanded(
          child: Divider(
            color: Kcolor.darkGreyColor,
          ),
        ),
      ],
    );
  }
}
