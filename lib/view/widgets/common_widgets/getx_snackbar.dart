import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/text_style.dart';

SnackbarController getxSnackbar({required String title, required String msg}) {
  return Get.snackbar("", "",
      titleText: Text(
        title,
        style: appStyle(
          size: 16.sp,
          color: Kcolor.blackColor,
          fontWeight: FontWeight.w900,
        ).copyWith(letterSpacing: 2),
      ),
      messageText: Text(
        msg,
        style: appStyle(
          size: 15.sp,
          color: Kcolor.blackColor,
          fontWeight: FontWeight.w400,
        ).copyWith(letterSpacing: 2),
      ),
      margin: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
      animationDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM);
}
