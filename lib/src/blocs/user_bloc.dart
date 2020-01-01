import 'package:rxdart/rxdart.dart';

import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/user_repository.dart';


class UserBloc{
  final _userRepository = UserRepository();
  final _userFetcher = BehaviorSubject<User>();

  Observable<User> get user => _userFetcher.stream;

  void fetchUserData(String email) async {
    _userRepository.getUser(email).then((user){
      _userFetcher.sink.add(user);
    });
  }

  void dispose(){
    _userFetcher.close();
  }
}
