// NetNinja#L6 we are using MyUser instead of User

class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class MyUserData {
  final String? uid;
  final String? name;
  final String? sugars;
  final int? strength;

  MyUserData({this.uid, this.sugars, this.name, this.strength});
}
