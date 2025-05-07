class User {
  final String uid;
  final String? name;
  final String? email;

  User({
    required this.uid,
    this.name,
    this.email,
  });

  factory User.fromMap(Map<String, dynamic> map, String uid) {
    return User(
      uid: uid,
      name: map['name'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
