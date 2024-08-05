import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:uber_clone/controller/user_controller.dart';
import 'package:uber_clone/model/user_model.dart';
import 'package:uber_clone/view/screens/authentication_screens/name_input_screen.dart';
import 'package:uber_clone/view/screens/authentication_screens/otp_verification_screen.dart';
import 'package:uber_clone/view/screens/authentication_screens/signup_screen.dart';
import 'package:uber_clone/view/screens/home_screen.dart';
import 'package:uber_clone/view/widgets/common_widgets/getx_snackbar.dart';

enum SignUpMethod {
  phoneNumber,
  google,
}

class AuthenticationController extends GetxController {
  final userController = Get.put(UserController());
  RxString isSigned = "".obs;
  String signupMethod = "";
  String phoneNumber = "";
  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  bool isSignedBefore = false;
  final _auth = FirebaseAuth.instance;
  var userList = <Userr>[].obs;
  String isBlocked = "no";
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('users');

  @override
  void onInit() async {
    super.onInit();
    await isLoggedRead();
  }

  signUPWithPhoneNumber() async {
    List<Userr> users = [];
    isLoading.value = true;
    if (phoneNumber.length < 11) {
      isLoading.value = false;
      getxSnackbar(title: "Error", msg: "Invalid phone number");
    } else {
      DatabaseEvent event = await _databaseReference.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<String, dynamic> usersMap =
            Map<String, dynamic>.from(snapshot.value as Map);
        users = usersMap.entries
            .map((entry) =>
                Userr.fromJson(Map<String, dynamic>.from(entry.value)))
            .toList();
      }

      userList.value = users;
      if (users.isNotEmpty) {
        for (var i in users) {
          if (i.phoneNumber == phoneNumber) {
            isSignedBefore = true;
            isBlocked = i.isBlocked;

            break;
          }
        }
      } else {
        isSignedBefore = false;
      }

      if (isSignedBefore) {
        isLoading.value = false;
        if (isBlocked == "no") {
          Get.offAll(const HomeScreen());
          isLogged("yes");
          getxSnackbar(title: "Success", msg: "User logged in successfully.");
        } else {
          getxSnackbar(
              title: "Error", msg: "User is blocked, please contact support.");
        }
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
    List<Userr> users = [];
    isGoogleLoading.value = true;
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final creds = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      await _auth.signInWithCredential(creds);
      signupMethod = SignUpMethod.google.name;

      //upload user data to firebase

      DatabaseEvent event = await _databaseReference.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<String, dynamic> usersMap =
            Map<String, dynamic>.from(snapshot.value as Map);
        users = usersMap.entries
            .map((entry) =>
                Userr.fromJson(Map<String, dynamic>.from(entry.value)))
            .toList();
      }

      userList.value = users;
      if (users.isNotEmpty) {
        for (var i in users) {
          if (i.email == googleUser!.email) {
            isSignedBefore = true;
            isBlocked = i.isBlocked;

            break;
          }
        }
      } else {
        isSignedBefore = false;
      }

      if (isSignedBefore) {
        if (isBlocked == "no") {
          isGoogleLoading.value = false;
          getxSnackbar(title: "Success", msg: "User logged in successfully.");

          Get.offAll(const HomeScreen());
          isLogged("yes");
        } else {
          getxSnackbar(
              title: "Error", msg: "User is blocked, please contact support.");
        }
      } else {
        userController.addUser(Userr(
          uid: _auth.currentUser!.uid,
          name: googleUser!.displayName!,
          email: googleUser.email,
          signUpMethod: signupMethod,
        ));
        isGoogleLoading.value = false;
        Get.offAll(const HomeScreen());
        isLogged("yes");
        getxSnackbar(title: "Success", msg: "User logged in successfully.");
      }
    } catch (e) {
      isGoogleLoading.value = false;
      getxSnackbar(title: "Error", msg: e.toString());
    }
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> isLogged(String isLoggedIn) async {
    await _storage.write(key: 'isLoggedIn', value: isLoggedIn);
  }

  isLoggedRead() async {
    String? res = await _storage.read(key: 'isLoggedIn');
    isSigned.value = res == "yes" ? "yes" : "no";
  }

  Future<void> signOut() async {
    try {
      signupMethod == SignUpMethod.google.name
          ? await GoogleSignIn().signOut()
          : _auth.signOut();

      Get.offAll(const SignUpScreen());
      getxSnackbar(title: "", msg: "User Logged out");
      isLogged("no");
    } catch (e) {
      print("Something went wrong");
    }
  }
}
