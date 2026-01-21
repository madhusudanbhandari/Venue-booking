import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signup(String email, String password) async {
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

  Future<User> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("Email not registered");
      } else if (e.code == 'wrong-password') {
        throw Exception("Password mismatch");
      } else if (e.code == 'invalid-email') {
        throw Exception("Invalid email format");
      } else {
        throw Exception("Login failed. Please try again");
      }
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
