import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/utils/utils.dart';

class FirebaseAuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var _db = Firestore.instance;

  createUser(User user) async {
    _db
        .collection('users')
        .document(user.email)
        .setData(user.toJson())
        .then((_) {
      print('successfully created user document!');
    }).catchError((err) => throw (err.toString()));
  }

  Future<User> firebaseAuthSignIn(
      String email, String password, BuildContext context) async {
    User user;
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult == null) {
        throw ("Failed to login to Firebase Authentication.");
      }
      print("Firebase user data: $authResult");
      FirebaseUser firebaseUser = authResult.user;
      print("Email: ${firebaseUser.email}");

      DocumentSnapshot docSnap =
          await _db.collection('users').document(firebaseUser.email).get();
      user = User.fromJson(docSnap.data);
      return user;
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getAlertDialog('Sign In Error',
                  'User already created with the same mail.', context);
            });
//        Flutter.showToast(msg: 'User already created with the same mail');
      } else {
        print('login error: $e');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getAlertDialog('Error', 'Sign In Error: $e', context);
            });
      }
      rethrow;
    }
  }

  //fireBaseGoogleSignUp
  Future<User> fireBaseGoogleSignInSignUp(BuildContext context) async {
    try {
      User user;
      GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser fireBaseUser =
          (await _auth.signInWithCredential(credential)).user;
      QuerySnapshot snapshot = await _db
          .collection('users')
          .where('email', isEqualTo: fireBaseUser.email)
          .getDocuments();

      var documentsFound = snapshot.documents.length;

      //Add Google Account to Users Collection to have an access to the app's database
      if (documentsFound < 1) {
        User newUser = User(
            uid: fireBaseUser.uid,
            displayName: fireBaseUser.displayName,
            email: fireBaseUser.email,
            providerId: GoogleAuthProvider.providerId,
            netWorth: 10000);

        createUser(newUser);

        user = newUser;
      }
      //User Already Registered to the firebase collection
      //Will proceed to Login Method
      else if (documentsFound == 1) {
        user = User.fromJson(snapshot.documents[0].data);
      } else {
        print('Overlapped Data!');
      }
      return user;
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getAlertDialog('Google Sign In Error',
                  'User already created with the same mail.', context);
            });
//        Flutter.showToast(msg: 'User already created with the same mail');
      } else {
        print('google login error: $e');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getAlertDialog(
                  'Error', 'Google Sign In Error: $e', context);
            });
      }
      rethrow;
    }
  }

  Future<User> firebaseAuthSignUp(User registerUser, String password) async {
    var firebaseUser = await _auth.createUserWithEmailAndPassword(
        email: registerUser.email, password: password);
    User user;
    if (firebaseUser == null) {
      throw ('Failed to create Firebase User.');
    }
    print('firebase user data:');
    print(firebaseUser);
    user = User(
        uid: firebaseUser.user.uid,
        email: firebaseUser.user.email,
        displayName: registerUser.displayName,
        gender: registerUser.gender ?? null,
        birthday: registerUser.birthday ?? null,
        location: registerUser.location ?? null,
        providerId: EmailAuthProvider.providerId,
        netWorth: 10000);
    createUser(user);
    return user;
  }

  Future<User> fireBaseFacebookSignInSignUp(BuildContext context) async {
    try {
      FacebookLogin _facebookLogin = FacebookLogin();
      User user;
      //facebook auth part
      var result = await _facebookLogin.logIn(['email']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        //Facebook connection to Google Service
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        AuthResult authResult = await _auth.signInWithCredential(credential);
        FirebaseUser firebaseUser = authResult.user;
        //Ref: signInUser
        QuerySnapshot snapshot = await _db
            .collection('users')
            .where('email', isEqualTo: firebaseUser.email)
            .getDocuments();

        var documentsFound = snapshot.documents.length;

        if (documentsFound < 1) {
          User _user = User(
              uid: firebaseUser.uid,
              email: firebaseUser.email,
              displayName: firebaseUser.displayName,
              providerId: FacebookAuthProvider.providerId,
              netWorth: 10000);
          user = _user;
          createUser(_user);
        } else if (documentsFound == 1) {
          user = User.fromJson(snapshot.documents[0].data);
        } else {
          print('Overlapped Data!');
        }
      }
      return user;
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getAlertDialog('Facebook Sign In Error',
                  'User already created with the same mail.', context);
            });
//        Flutter.showToast(msg: 'User already created with the same mail');
      } else {
        print('facebook login error: $e');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return getAlertDialog(
                  'Error', 'Facebook Sign In Error: $e', context);
            });
      }
      rethrow;
    }
  }

  Future<User> checkCurrentUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      DocumentSnapshot userOnDb =
          await _db.collection('users').document(firebaseUser.email).get();
      User user = User.fromJson(userOnDb.data);
      return user;
    }
    return null;
  }

  Future<void> logOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error occured $e');
    }
  }

  Future<bool> updateUserProfile(User updateUser) async {
    try {
      FirebaseUser fireBaseUser = await _auth.currentUser();
      _db.collection('users').document(fireBaseUser.email).updateData({
        'displayName': updateUser.displayName,
        'gender': updateUser.gender,
        'birthday': updateUser.birthday,
        'location': updateUser.location
      });
      return true;
    } catch (e) {
      print('Error updating data: $e');
      return false;
    }
  }
}
