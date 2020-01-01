

import 'package:rxdart/rxdart.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/friends_repository.dart';

class FriendsBloc{
  // repository for fetching friends, get user id first then return his list of friends
  final _friendsRepository = FriendsRepository();

  final _friendsFetcher = BehaviorSubject<List<User>>();
  Observable<List<User>> get friends => _friendsFetcher.stream;

  final _strangersFetcher = BehaviorSubject<List<User>>();
  Observable<List<User>> get strangers => _strangersFetcher.stream;


  void fetchUserFriends(String email){
    _friendsRepository.getFriends(email).then((friends){
      _friendsFetcher.sink.add(friends);
    });
  }

  void fetchStrangers(String email) async{
    _strangersFetcher.sink.add(null);
    await _friendsRepository.getStrangers(email).then((strangers){
      _strangersFetcher.sink.add(strangers);
    });
  }
  Future<bool> addFriend(String yourEmail, String targetEmail)async{
    bool status = false;
    await _friendsRepository.addFriend(yourEmail, targetEmail).then((_){
      status = true;
    });
    return status;
  }

  Future<bool> unFriend(String yourEmail, String targetEmail)async{
    bool status = false;
    await _friendsRepository.unFriend(yourEmail, targetEmail).then((_){
      status = true;
    });
    return status;
  }


  void dispose(){
    _friendsFetcher.close();
    _strangersFetcher.close();
  }
}