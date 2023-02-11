class User {
  int? id;
  String username;
  String password;

  User({
    this.id,
    required this.username,
    required this.password,
  });

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        username = res["username"],
        password = res["password"];

  Map<String, Object?> toMap() {
    return {'id': id, 'username': username, 'password': password};
  }
}
