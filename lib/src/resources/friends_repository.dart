import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/friends_provider.dart';

class FriendsRepository{
  final friendsApiProvider = FriendsApiProvider();
  Future<List<User>> getFriends(String email) => friendsApiProvider.getFriends(email);
  Future<List<User>> getStrangers(String email) => friendsApiProvider.getStrangers(email);
  Future<void> addFriend(String yourEmail, String targetEmail) => friendsApiProvider.addFriend(yourEmail, targetEmail);
  Future<void> unFriend(String yourEmail, String targetEmail) => friendsApiProvider.unFriend(yourEmail, targetEmail);
}