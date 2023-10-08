import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/home/repos/auth_repository.dart';
import 'package:historycollection/screens/login/models/user_model.dart';

class AuthViewModel extends AutoDisposeAsyncNotifier<void> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late final AuthRepository _repository;
  late UserModel userInfo;

  @override
  FutureOr<void> build() async {
    // throw UnimplementedError();
    _repository = ref.read(authRepository);

    userInfo = UserModel.empty();
  }

  Future<void> signUpWithGoogle() async {
    // Trigger the authentication flow
    final result = await _repository.signUpWithGoogle();

    if (result != null) {
      if (result.user != null) {
        final user = result.user;

        final userModel = UserModel(
          userName: user!.displayName,
          userEmail: user.email,
          avatarUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
          isEmailVertified: user.emailVerified,
        );

        userInfo = userModel;
      }
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }

  UserModel? get getUserInfo {
    final curUser = _firebaseAuth.currentUser;

    if (curUser == null) {
      return null;
    }

    return UserModel(
      userEmail: curUser.email,
      userName: curUser.displayName,
      phoneNumber: curUser.phoneNumber,
      avatarUrl: curUser.photoURL,
      isEmailVertified: curUser.emailVerified,
    );
  }

  bool get isLoggined => _repository.isLoggined;
}

final authProvider = AutoDisposeAsyncNotifierProvider<AuthViewModel, void>(
  () {
    return AuthViewModel();
  },
);
