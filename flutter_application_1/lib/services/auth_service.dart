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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception(
          "This email is already registered. Please login instead.",
        );
      } else if (e.code == 'weak-password') {
        throw Exception(
          "Password is too weak. Please use a stronger password.",
        );
      } else if (e.code == 'invalid-email') {
        throw Exception("Invalid email format.");
      } else {
        throw Exception("Registration failed: ${e.message}");
      }
    } catch (e) {
      throw Exception(
        "An error occurred during registration. Please try again.",
      );
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
      print(
        "Firebase Auth Error Code: ${e.code}",
      ); // Add this to see actual error
      print("Firebase Auth Error Message: ${e.message}"); // Add this too

      if (e.code == 'user-not-found') {
        throw Exception("Email not registered");
      } else if (e.code == 'wrong-password') {
        throw Exception("Password mismatch");
      } else if (e.code == 'invalid-email') {
        throw Exception("Invalid email format");
      } else if (e.code == 'invalid-credential') {
        throw Exception("Invalid email or password");
      } else if (e.code == 'user-disabled') {
        throw Exception("This account has been disabled");
      } else if (e.code == 'too-many-requests') {
        throw Exception("Too many attempts. Please try again later");
      } else {
        throw Exception(
          "Login failed: ${e.message}",
        ); // Show actual error message
      }
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No account found with this email');
      } else if (e.code == 'invalid-email') {
        throw Exception('Invalid email address');
      } else {
        throw Exception('Failed to send reset email: ${e.message}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
