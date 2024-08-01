import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/text_style.dart';
import 'package:uber_clone/controller/common_methods_controller.dart';

import 'package:uber_clone/view/widgets/common_widgets/btn_1_widget.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({
    super.key,
    required this.connectionController,
  });

  final CommonMethodsController connectionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "You are offline",
          style: appStyle(
              size: 38.sp,
              color: Kcolor.darkGreyColor,
              fontWeight: FontWeight.w900),
        ),
        Text(
          "check your connection and try again.",
          style: appStyle(
              size: 15.sp,
              color: Kcolor.darkGreyColor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 20.h),
        Btn1Widget(
            bgColor: Kcolor.blackColor,
            title: Text(
              "Reload",
              style: appStyle(
                  size: 17.sp,
                  color: Kcolor.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
            function: () {
              connectionController.checkConnectivity();
            })
      ],
    );
  }
}
