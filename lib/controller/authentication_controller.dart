import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:uber_clone/controller/user_controller.dart';
import 'package:uber_clone/model/user_model.dart';
import 'package:uber_clone/view/screens/authentication_screens/name_input_screen.dart';
import 'package:uber_clone/view/screens/authentication_screens/otp_verification_screen.dart';
import 'package:uber_clone/view/screens/home_screen.dart';
import 'package:uber_clone/view/widgets/getx_snackbar.dart';

enum SignUpMethod {
  phoneNumber,
  google,
}

class AuthenticationController extends GetxController {
  final userController = Get.put(UserController());
  String signupMethod = "";
  String phoneNumber = "";
  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  bool isSignedBefore = false;
  final _auth = FirebaseAuth.instance;
  var userList = <Userr>[].obs;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('users');

  signUPWithPhoneNumber() async {
    isLoading.value = true;
    if (phoneNumber.length < 11) {
      isLoading.value = false;
      getxSnackbar(title: "Error", msg: "Invalid phone number");
    } else {
      DatabaseEvent event = await _databaseReference.once();
      DataSnapshot snapshot = event.snapshot;

      Map<String, dynamic> usersMap =
          Map<String, dynamic>.from(snapshot.value as Map);
      List<Userr> users = usersMap.entries
          .map(
              (entry) => Userr.fromJson(Map<String, dynamic>.from(entry.value)))
          .toList();
      userList.value = users;
      for (var i in users) {
        if (i.phoneNumber == phoneNumber) {
          isSignedBefore = true;
          break;
        }
      }

      if (isSignedBefore) {
        Get.offAll(const HomeScreen());
        getxSnackbar(title: "Success", msg: "User logged in successfully.");
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (error) {
            isLoading.value = false;
            getxSnackbar(title: "Error", msg: "Verification failed");
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
  }

  verifyOtp(String verificationId, String otp) async {
    isLoading.value = true;
    try {
      final cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await _auth.signInWithCredential(cred);
      isLoading.value = false;
      Get.to(const NameInputScreen());
    } catch (e) {
      isLoading.value = false;
      getxSnackbar(title: "Error", msg: "Invalid code");
    }
  }

  signUpWithGoogle() async {
    isGoogleLoading.value = true;
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final creds = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      await _auth.signInWithCredential(creds);
      signupMethod = SignUpMethod.google.name;

      //upload user data to firebase
      userController.addUser(Userr(
        uid: _auth.currentUser!.uid,
        name: googleUser!.displayName!,
        email: googleUser.email,
        signUpMethod: signupMethod,
      ));

      isGoogleLoading.value = false;

      getxSnackbar(title: "Success", msg: "User logged in successfully.");

      Get.offAll(const HomeScreen());
    } catch (e) {
      isGoogleLoading.value = false;
      getxSnackbar(title: "Error", msg: e.toString());
    }
  }
}
