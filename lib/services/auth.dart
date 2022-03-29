import 'package:coffee_crew/models/my_user.dart';
import 'package:coffee_crew/services/databases.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // NetNinja#L4 Step#1 Create an instance of firebase auth service

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 📌 MyUser is user-defined object type and User is the firebaseAuth object
  MyUser? _userFromFireBaseUser(User? user) {
    return (user != null) ? MyUser(uid: user.uid) : null;
  }

  // NetNinja#L7
  //Auth change user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFireBaseUser(user));

    // ⭐ (User? user) => _userFromFireBaseUser(user)
    // ------------  is same as ------------
    // MyUser? _userFromFireBaseUser(User? user) {
    //     return (user != null) ? MyUser(uid: user.uid) : null;
    //   }
    //
    //  ---------------we can replace--------------
    //  return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  // NetNinja#L4 => Sign in anonymously

  Future signInAnon() async {
    // 👈 We had not specified the Future<Type>
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      // using the user-defined method to return user-defined object id
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // NetNinja#L12 Registering with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user; // Firebase user

      await DatabaseService(uid: user!.uid).updateUserData('0', 'new-user', 100);

      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString() + " 💀");
      return null;
    }
  }

  // NetNinja#L13 Signing In

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString() + " 💀");
    }
  }

  // NetNinja#L9 ===>  SignOUT

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString() + " 🌋");
      return null;
    }
  }
}
