import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/view/screens/authentication_screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Uber clone user app',
            theme: ThemeData(
              scaffoldBackgroundColor: Kcolor.whiteColor,
              colorScheme: ColorScheme.fromSeed(seedColor: Kcolor.whiteColor),
              useMaterial3: true,
            ),
            home: const SignUpScreen(),
          );
        });
  }
}
