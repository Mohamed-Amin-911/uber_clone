class Userr {
  final String uid;
  final String name;
  final String isBlocked;
  final String email;
  final String phoneNumber;
  final String signUpMethod;
  Userr(
      {required this.uid,
      required this.name,
      this.isBlocked = "no",
      this.email = "",
      this.phoneNumber = "",
      this.signUpMethod = ""});
  // Convert a Map object into a User object
  factory Userr.fromJson(Map<String, dynamic> json) {
    return Userr(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        isBlocked: json['isBlocked'],
        phoneNumber: json['phoneNumber'],
        signUpMethod: json['signUpMethod']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'isBlocked': isBlocked,
      'phoneNumber': phoneNumber,
      'signUpMethod': signUpMethod,
    };
  }
}
