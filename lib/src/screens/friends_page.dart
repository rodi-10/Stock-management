import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/friends_bloc.dart';
import 'package:yourvone/src/blocs/user_bloc.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/utils/utils.dart';

import 'package:yourvone/src/widgets/friends_list_header.dart';
import 'package:yourvone/src/widgets/friends_list_body.dart';


class FriendsPage extends StatefulWidget{
  final User user;
  FriendsPage({Key key, @required this.user}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  var userBloc = UserBloc();
  var friendsBloc = FriendsBloc();

  @override
  void initState() {
    // TODO: implement initState
    userBloc.fetchUserData(widget.user.email);
    friendsBloc.fetchUserFriends(widget.user.email);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userBloc.dispose();
    friendsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FriendsListHeader(),
            FriendsListBody(email: widget.user.email, friendsBloc: friendsBloc)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: (){
          Navigator.pushNamed(context, RoutesScreen.ADD_FRIEND, arguments: [widget.user.email, friendsBloc]).then((onValue){
//            friendsBloc.fetchUserFriends();
          });
        }
      ),
    );
  }
}