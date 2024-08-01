import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/text_style.dart';
import 'package:uber_clone/controller/authentication_controller.dart';
import 'package:uber_clone/view/widgets/common_widgets/btn_1_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otpTxt = "";
  var controller = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor.whiteColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 30.h),
              Text(
                "OTP verification",
                style: appStyle(
                        size: 34.sp,
                        color: Kcolor.blackColor,
                        fontWeight: FontWeight.w900)
                    .copyWith(letterSpacing: 2),
              ),
              SizedBox(height: 5.h),
              Text(
                "Enter verification code sent to your number.",
                style: appStyle(
                    size: 18.sp,
                    color: Kcolor.blackColor,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 60.h),
              OtpTextField(
                keyboardType: TextInputType.phone,
                numberOfFields: 6,
                borderRadius: BorderRadius.circular(10.r),
                fieldHeight: 100.h,
                fieldWidth: 40.w,
                borderColor: Kcolor.blackColor,
                showFieldAsBox: true,
                onSubmit: (value) {
                  otpTxt = value;
                },
                disabledBorderColor: Kcolor.blackColor,
                focusedBorderColor: Kcolor.blackColor,
                fillColor: Kcolor.blackColor,
                filled: true,
                cursorColor: Kcolor.whiteColor,
                textStyle: appStyle(
                    size: 15.sp,
                    color: Kcolor.whiteColor,
                    fontWeight: FontWeight.w600),
              ),

              Obx(
                () => Btn1Widget(
                    bgColor: Kcolor.blackColor,
                    title: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Kcolor.whiteColor)
                        : Text(
                            "Submit",
                            style: appStyle(
                                size: 17.sp,
                                color: Kcolor.whiteColor,
                                fontWeight: FontWeight.w500),
                          ),
                    function: () {
                      controller.verifyOtp(widget.verificationId, otpTxt);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
