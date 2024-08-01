import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/text_style.dart';
import 'package:uber_clone/controller/authentication_controller.dart';

class PhoneNumberInputWidget extends StatelessWidget {
  const PhoneNumberInputWidget({
    super.key,
    required this.controller,
  });

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        controller.phoneNumber = number.phoneNumber!;
        // print(controller.phoneNumber);
      },
      countrySelectorScrollControlled: true,
      ignoreBlank: true,
      scrollPadding: EdgeInsets.only(top: 60.h),
      textStyle: appStyle(
          size: 15.sp, color: Kcolor.blackColor, fontWeight: FontWeight.w400),
      selectorConfig: const SelectorConfig(
        useEmoji: true,
        selectorType: PhoneInputSelectorType.DROPDOWN,
      ),
      keyboardType: TextInputType.phone,
      inputDecoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Kcolor.blackColor,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(10.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Kcolor.greyColor,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(10.r)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Kcolor.blackColor,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      cursorColor: Kcolor.blackColor,
    );
  }
}
