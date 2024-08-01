import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uber_clone/model/user_model.dart';

class UserController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('users');
  var userList = <Userr>[].obs;
  Rx<Userr?> user = Rx<Userr?>(null);

//add user
  Future<void> addUser(Userr user) async {
    await _databaseReference.child(_auth.currentUser!.uid).set(user.toJson());
  }

  // Fetch user data from the database
  void fetchUser() async {
    User? firebaseUser = _auth.currentUser;

    DatabaseEvent event =
        await _databaseReference.child(firebaseUser!.uid).once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.exists) {
      user.value =
          Userr.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
  }

// Fetch all users from the database
  Future<void> fetchAllUsers() async {
    DatabaseEvent event = await _databaseReference.once();
    DataSnapshot snapshot = event.snapshot;

    Map<String, dynamic> usersMap =
        Map<String, dynamic>.from(snapshot.value as Map);
    List<Userr> users = usersMap.entries
        .map((entry) => Userr.fromJson(Map<String, dynamic>.from(entry.value)))
        .toList();
    userList.value = users;
  }
}
