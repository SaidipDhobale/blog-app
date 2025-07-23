// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email,
   
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

}
