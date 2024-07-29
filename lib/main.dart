import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber_clone/constants/colors.dart';
import 'package:uber_clone/firebase_options.dart';
import 'package:uber_clone/view/screens/authentication_screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          return GetMaterialApp(
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
