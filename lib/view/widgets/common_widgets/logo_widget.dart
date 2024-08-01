import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:uber_clone/constants/colors.dart';

import 'package:uber_clone/constants/text_style.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            textAlign: TextAlign.center,
            "UBER",
            style: appStyle(
                    size: 100.sp,
                    color: Kcolor.blackColor,
                    fontWeight: FontWeight.w900)
                .copyWith(height: 0.8.h),
          ),
        ),
        Center(
          child: Row(
            children: [
              SizedBox(width: 39.w),
              Text(
                textAlign: TextAlign.center,
                "CLONE",
                style: appStyle(
                        size: 40.sp,
                        color: Kcolor.blackColor,
                        fontWeight: FontWeight.w400)
                    .copyWith(
                  height: 0.8.h,
                  letterSpacing: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
