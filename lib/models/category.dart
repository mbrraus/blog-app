class Category {
  String name;

  Category({required this.name});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        name: map['name'] // ????
        );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,

    };
  }
}
