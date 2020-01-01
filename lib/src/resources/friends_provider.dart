import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourvone/src/models/user_model.dart';

class FriendsApiProvider{
  final Firestore _db = Firestore.instance;
  CollectionReference userRef;
  FriendsApiProvider(){
    userRef = _db.collection('users');
  }
  Future<List<User>> getFriends(String email) async{
    List<User> friends = [];
    await userRef.document(email).get().then((userSnap){
      List<dynamic> friendsListRef = userSnap.data['friends'];
        if (friendsListRef != null){
          friendsListRef.forEach((friendRef){
            userRef.document(friendRef).get().then((user){
              friends.add(User.fromJson(user.data));
            });
          });
        }
    });
    return friends;
  }

  Future<List<User>> getStrangers(String email) async{
    List<User> allUsers = [];
    await userRef.getDocuments().then((docsSnap){
      allUsers = docsSnap.documents.map((doc) => User.fromJson(doc.data)).toList();
    });
    allUsers.removeWhere((item) => item.email == email);
    await userRef.document(email).get().then((updatedUser){
      if(updatedUser.exists){
        User _upUser = User.fromJson(updatedUser.data);
        if(_upUser.friends != null){
          _upUser.friends.forEach((userFriend){
            allUsers.removeWhere((item) => item.email == userFriend);
          });
        }
      }
    });
    return allUsers;
  }

  Future<void> addFriend(String yourEmail, String targetEmail) async{
    userRef.document(yourEmail).setData({
      "friends": FieldValue.arrayUnion([targetEmail])
    }, merge: true).then((_){
      userRef.document(targetEmail).setData({
        "friends": FieldValue.arrayUnion([yourEmail])
      }, merge: true);
    });
  }

  Future<void> unFriend(String yourEmail, String targetEmail) async{
    userRef.document(yourEmail).setData({
      "friends": FieldValue.arrayRemove([targetEmail])
    }, merge: true).then((_){
      userRef.document(targetEmail).setData({
        "friends": FieldValue.arrayRemove([yourEmail])
      }, merge: true);
    });
  }
}