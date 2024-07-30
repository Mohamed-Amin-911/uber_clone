import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/icon_assets.dart';
import 'package:uber_clone/constants/text_style.dart';
import 'package:uber_clone/controller/authentication_controller.dart';
import 'package:uber_clone/controller/common_methods_controller.dart';
import 'package:uber_clone/view/widgets/authentication_widgets/divider_widget.dart';
import 'package:uber_clone/view/widgets/authentication_widgets/phone_number_input_widget.dart';
import 'package:uber_clone/view/widgets/btn_1_widget.dart';
import 'package:uber_clone/view/widgets/logo_widget.dart';
import 'package:uber_clone/view/widgets/oflline_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = Get.put(AuthenticationController());
  var connectionController = Get.put(CommonMethodsController());
  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                const LogoWidget(),
                SizedBox(height: 100.h),
                connectionController.isOnline.value
                    ? Column(
                        children: [
                          //sign in with phone number
                          Text(
                            "Enter your mobile number",
                            style: appStyle(
                                size: 17.sp,
                                color: Kcolor.blackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.h),
                          PhoneNumberInputWidget(controller: controller),
                          SizedBox(height: 20.h),
                          //submit phone number
                          Obx(
                            () => Btn1Widget(
                                bgColor: Kcolor.blackColor,
                                title: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Kcolor.whiteColor,
                                      )
                                    : Text(
                                        "Continue",
                                        style: appStyle(
                                            size: 17.sp,
                                            color: Kcolor.whiteColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                function: () async {
                                  connectionController.checkConnectivity();
                                  controller.signUPWithPhoneNumber();
                                }),
                          ),
                          SizedBox(height: 50.h),
                          const DividerWidget(),
                          SizedBox(height: 15.h),
                          //sign in with google
                          Obx(
                            () => Btn1Widget(
                              bgColor: Kcolor.greyColor,
                              title: controller.isGoogleLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Kcolor.blackColor)
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              function: () {
                                connectionController.checkConnectivity();
                                controller.signUpWithGoogle();
                              },
                            ),
                          ),
                        ],
                      )
                    : OfflineWidget(connectionController: connectionController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
