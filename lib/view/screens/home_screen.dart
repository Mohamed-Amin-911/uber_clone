import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/controller/authentication_controller.dart';

import 'package:uber_clone/view/widgets/common_widgets/btn_2_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var authController = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const Spacer(),
          Btn2Widget(
              bgColor: Kcolor.blackColor,
              title: "Logout",
              function: () {
                authController.signOut();
              }),
        ],
      ),
    ));
  }
}
