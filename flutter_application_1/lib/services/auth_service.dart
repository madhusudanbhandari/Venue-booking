import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signin(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Error in signInWithEmailAndPassword: $e");
      return null;
    }
  }
}

Future<User?> login(String email, String password) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  } catch (e) {
    print("Error in login: $e");
    return null;
  }
}

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}
