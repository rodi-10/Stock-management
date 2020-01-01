import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/firebase_auth_repository.dart';


class AuthBloc{

  final _repository = FirebaseAuthRepository();
  final _userAuthStream = BehaviorSubject<User>();

  User _user;
  User get user => _user;
//  Observable<User> get currentUser => _userAuthStream.stream;

  /// If the user does exist, push it into the behavior subject stream
  Future<User> fetchCurrentUser() async {
    User user  = await _repository.checkCurrentUser();
    if (user != null) {
      _user = user;
    }
    return user;
  }
  
  Future <User> signIn(String email, String password, BuildContext context) async {
    try{
      // FIXME: i added a try catch block because i wanted to see what the error is.
      // FIXME: also, i forgot how we were able to add the user object to the stream before, so I added line 27. @darren
      User user = await _repository.signIn(email, password, context);
      _user = user;
//      _userAuthStream.sink.add(user);
      return user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<User> googleSignInSignUp(BuildContext context) async {
    try{
      User user = await _repository.googleSignInSignUp(context);
      if(user != null) {
        _user = user;
//        _userAuthStream.sink.add(user);
      }
      return user;
    }
    catch(e){
      print('An error occured on GoogleSignIn$e');
    }
    return null;
  }

  Future<User> facebookSignInSignUp(BuildContext context) async{
    try{
      User user = await _repository.fireBaseFacebookSignInSignUp(context);
      if(user != null) {
        _user = user;
//        _userAuthStream.sink.add(user);
      }
      return user;
    }
    catch(e){
      print('An error occured on FacebookSignIn$e');
    }
    return null;
  }

  Future<User> signUp(User registerUser, String password) async {
    try{
      User user = await _repository.signUp(registerUser, password);
//      _userAuthStream.sink.add(user);
      return user;
    }catch(e){
      print(e);
    }
    return null;
  }

  Future<void> signOutUser() async {
    try{
      await _repository.signOutUser();
      dispose();
    }
    catch(e){
      print('an error occured $e');
    }
  }

  Future<bool> updateUser(User updateUser) async {
    try{
     return await _repository.updateUser(updateUser);
    }
    catch(e){
      print('an error occure $e');
      return false;
    }
  }
  
  void dispose(){
    _userAuthStream.close();
  }
}
