import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/constants/icon_assets.dart';
import 'package:uber_clone/constants/text_style.dart';
import 'package:uber_clone/view/widgets/btn_1_widget.dart';
import 'package:uber_clone/view/widgets/txtfield_1_widget.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
              right: 16.w,
              left: 16.w,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                //image
                Center(
                  child: SvgPicture.asset(
                    width: 220.w,
                    KIconAssets.profile.toString(),
                  ),
                ),
                SizedBox(height: 30.h),
                //first name
                Text(
                  "First name",
                  style: appStyle(
                      size: 17.sp,
                      color: Kcolor.blackColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.h),
                TxtField1(controller: firstNameController),
                SizedBox(height: 30.h),
                //last name
                Text(
                  "Last name",
                  style: appStyle(
                      size: 17.sp,
                      color: Kcolor.blackColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.h),
                TxtField1(controller: lastNameController),
                SizedBox(height: 30.h),
                //email
                Text(
                  "Email",
                  style: appStyle(
                      size: 17.sp,
                      color: Kcolor.blackColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.h),
                TxtField1(controller: lastNameController),
                SizedBox(height: 40.h),
                //continue btn
                Btn1Widget(
                    bgColor: Kcolor.blackColor,
                    title: Text(
                      "Continue",
                      style: appStyle(
                          size: 17.sp,
                          color: Kcolor.whiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                    function: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
