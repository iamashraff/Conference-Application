class Conference {
  int? id;
  String name;
  String email;
  int phone;
  String role;
  int specialize;
  int user;

  Conference(
      {this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.role,
      required this.specialize,
      required this.user});

  Conference.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        email = res["email"],
        phone = res["phone"],
        role = res["role"],
        specialize = res["specialize"],
        user = res["user"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'specialize': specialize,
      'user': user
    };
  }
}
