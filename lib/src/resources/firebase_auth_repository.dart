import 'package:flutter/cupertino.dart';

import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/firebase_auth_provider.dart';


class FirebaseAuthRepository{
  final _firebaseAuthProvider = FirebaseAuthProvider();

  Future<User> signUp(User registerUser, String password) => _firebaseAuthProvider.firebaseAuthSignUp(registerUser, password);
  Future<User> signIn(String email, String password, BuildContext context) => _firebaseAuthProvider.firebaseAuthSignIn(email, password, context);
  Future<User> checkCurrentUser() => _firebaseAuthProvider.checkCurrentUser(); // changed return type to User
  Future<User> googleSignInSignUp(BuildContext context) => _firebaseAuthProvider.fireBaseGoogleSignInSignUp(context);
  Future<User> fireBaseFacebookSignInSignUp(BuildContext context) => _firebaseAuthProvider.fireBaseFacebookSignInSignUp(context);
  Future<void> signOutUser() => _firebaseAuthProvider.logOutUser();
  Future<bool> updateUser(User updateUser) => _firebaseAuthProvider.updateUserProfile(updateUser);
}
