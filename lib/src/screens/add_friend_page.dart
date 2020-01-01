import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/friends_bloc.dart';
import 'package:yourvone/src/blocs/user_bloc.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';

class AddFriendPage extends StatelessWidget {
  final List<Object> args;
  AddFriendPage({Key key, @required this.args,}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    String email = args[0];
    FriendsBloc friendsBloc = args[1];
    friendsBloc.fetchStrangers(email);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: headerBackgroundColor,
              height: getHeightByScreen(context, ratio: 0.10),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Add Friend',
                        style: TextStyle(
                            color: PrimaryColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 30.0
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.search,
                        color: PrimaryColor,
                        size: 30.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder<List<User>>(
              stream: friendsBloc.strangers,
              builder: (context, strangersSnapshot) {
                if(strangersSnapshot.hasData){
                  return Expanded(
                    child: ListView.builder(
//                      physics: NeverScrollableScrollPhysics(),
                        itemCount: strangersSnapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(strangersSnapshot.data[index].displayName),
                            trailing: IconButton(icon: Icon(Icons.person_add), onPressed: (){
                              friendsBloc.addFriend(email, strangersSnapshot.data[index].email).then((success){
                                if(success){
                                  friendsBloc.fetchStrangers(email);
                                  friendsBloc.fetchUserFriends(email);
                                  Scaffold.of(context).showSnackBar(_snackBarWidget("${strangersSnapshot.data[index].displayName} is now on your friends list!"));
                                }
                              });
                            }),
                          );
                        }
                    ),
                  );
                } else{
                  return Center(child: CircularProgressIndicator());
                }
              }
            )
          ],
        ),
      ),
    );
  }

  Widget _snackBarWidget(String message){
    return SnackBar(content: Text(message, style: TextStyle(color: Colors.white),), backgroundColor: Colors.green);
  }
}
