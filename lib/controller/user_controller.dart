import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uber_clone/model/user_model.dart';

class UserController extends GetxController {
  final _auth = FirebaseAuth.instance;

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('users');

  Rx<Userr?> user = Rx<Userr?>(null);

  Future<void> addUser(Userr user) async {
    await _database.child(_auth.currentUser!.uid).set(user.toJson());
  }

  Future<void> fetchUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final snapshot = await _database.child(uid).get();
      if (snapshot.exists) {
        final userData = snapshot.value as Map<String, dynamic>;
        user.value = Userr.fromMap(userData);
      }
    }
  }
}
