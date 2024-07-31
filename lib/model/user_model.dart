class Userr {
  final String uid;
  final String name;

  final String email;
  final String phoneNumber;
  final String signUpMethod;
  Userr(
      {required this.uid,
      required this.name,
      this.email = "",
      this.phoneNumber = "",
      this.signUpMethod = ""});

  Userr.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        email = map['email'],
        phoneNumber = map['phoneNumber'],
        signUpMethod = map['signUpMethod'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'signUpMethod': signUpMethod,
    };
  }
}
