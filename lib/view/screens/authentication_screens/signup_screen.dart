import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/icon_assets.dart';
import 'package:uber_clone/constants/text_style.dart';
import 'package:uber_clone/view/widgets/authentication_widgets/divider_widget.dart';
import 'package:uber_clone/view/widgets/btn_1_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Text(
              "Enter your mobile number",
              style: appStyle(
                  size: 17.sp,
                  color: Kcolor.blackColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20.h),
            const PhoneNumberInputWidget(),
            SizedBox(height: 20.h),
            Btn1Widget(
                bgColor: Kcolor.blackColor,
                title: Text(
                  "Continue",
                  style: appStyle(
                      size: 17.sp,
                      color: Kcolor.whiteColor,
                      fontWeight: FontWeight.w500),
                ),
                function: () {}),
            SizedBox(height: 50.h),
            const DividerWidget(),
            SizedBox(height: 15.h),
            Btn1Widget(
                bgColor: Kcolor.greyColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      width: 30.w,
                      KIconAssets.google.toString(),
                    ),
                    Text(
                      "  Continue with Google",
                      style: appStyle(
                          size: 17.sp,
                          color: Kcolor.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                function: () {}),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberInputWidget extends StatelessWidget {
  const PhoneNumberInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      maxLength: 11,
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
              color: Kcolor.blackColor,
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
