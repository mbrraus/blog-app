enum Role { admin, editor, viewer }

class User {
  String id;
  String name;
  String surname;
  Role role;
  String email;

  User(
      {required this.id,
        required this.name,
      required this.surname,
      this.role = Role.viewer,
      required this.email});

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      surname: map['surname'] ?? '',
      role:
          Role.values.firstWhere((e) => e.toString() == 'Role.${map['role']}'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "email": email,
      "role": role.toString().split('.').last,
    };
  }
}
