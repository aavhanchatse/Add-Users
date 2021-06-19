class User {
  String? name;
  String? email;
  int? id;
  int? age;

  User({this.name, this.email, this.id, this.age});

  @override
  String toString() {
    return 'User: {name: ${name}, age: ${age}, email: ${email}, id: ${id}}';
  }
}
