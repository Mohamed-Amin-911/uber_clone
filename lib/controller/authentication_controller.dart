import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/view/screens/authentication_screens/name_input_screen.dart';
import 'package:uber_clone/view/screens/authentication_screens/otp_verification_screen.dart';

enum SignUpMethod {
  phoneNumber,
  google,
}

class AuthenticationController extends GetxController {
  String signupMethod = "";
  String phoneNumber = "";
  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  final _auth = FirebaseAuth.instance;

  signUPWithPhoneNumber() async {
    isLoading.value = true;
    if (phoneNumber.length < 11) {
      isLoading.value = false;
      Get.snackbar("Error", "Invalid phone number",
          animationDuration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // On auto-verification (instant verification on Android)
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          isLoading.value = false;
          Get.snackbar("Error", "Verification failed",
              animationDuration: const Duration(seconds: 2),
              snackStyle: SnackStyle.FLOATING,
              snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (verificationId, forceResendingToken) {
          isLoading.value = false;
          Get.to(OtpVerificationScreen(
            verificationId: verificationId,
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          // Get.snackbar("", "Code auto retrieval timeout");
        },
      );
    }
  }

  verifyOtp(String verificationId, String otp) async {
    isLoading.value = true;
    try {
      final cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await _auth.signInWithCredential(cred);
      isLoading.value = false;
      // Get.snackbar("success", "",
      //     animationDuration: const Duration(seconds: 2),
      //     snackStyle: SnackStyle.FLOATING,
      //     snackPosition: SnackPosition.BOTTOM);
      Get.to(const NameInputScreen());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Invalid code",
          animationDuration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  signUpWithGoogle() async {
    isGoogleLoading.value = true;
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final creds = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      // print(googleUser!.displayName);
      await _auth.signInWithCredential(creds);
      isGoogleLoading.value = false;
      Get.snackbar("Success", "",
          animationDuration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
      signupMethod = SignUpMethod.google.name;
    } catch (e) {
      isGoogleLoading.value = false;
      Get.snackbar("Error", e.toString(),
          animationDuration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
    }
    // return null;
  }
}
