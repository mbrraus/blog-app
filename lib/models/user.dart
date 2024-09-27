enum Role { admin, editor, viewer }

class User {
  String name;
  String surname;
  Role role;
  String email;

  User(
      {required this.name,
      required this.surname,
      this.role = Role.viewer,
      required this.email});

  static User defaultUser() {
    return User(name: 'Muberra', surname: 'Uslu', email: 'mbr@example.com');
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    if(map==null) {
      return defaultUser();
    }
    return User(
      name: map['name'],
      email: map['email'],
      surname: map['surname'],
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
