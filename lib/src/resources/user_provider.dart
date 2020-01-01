import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' show Client;

import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/firebase_auth_repository.dart';


class UserApiProvider {
  Client client = Client();
  final Firestore _db = Firestore.instance;
  CollectionReference userRef;
  UserApiProvider(){
    userRef = _db.collection('users');
  }

  Future<User> getUser(String email) async {
    User user;
    DocumentSnapshot docsnap = await userRef.document(email).get();
    user = User.fromJson(docsnap.data);
    return user;
  }
}

