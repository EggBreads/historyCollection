// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Google Login
  Future<UserCredential?> signUpWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final result = await _firebaseAuth.signInWithCredential(credential);

      return result;
    }

    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? get user => _firebaseAuth.currentUser;

  bool get isLoggined => _firebaseAuth.currentUser != null;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}

final authRepository = Provider((
  ref,
) =>
    AuthRepository());

final authStateStream = StreamProvider(
  (ref) {
    final repository = ref.read(authRepository);
    return repository.authStateChanges();
  },
);
