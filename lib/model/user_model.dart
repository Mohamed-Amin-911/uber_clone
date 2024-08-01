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
  // Convert a Map object into a User object
  factory Userr.fromJson(Map<String, dynamic> json) {
    return Userr(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        signUpMethod: json['signUpMethod']);
  }
  // Userr.fromMap(Map<String, dynamic> map)
  //     : uid = map['uid'],
  //       name = map['name'],
  //       email = map['email'],
  //       phoneNumber = map['phoneNumber'],
  //       signUpMethod = map['signUpMethod'];

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
