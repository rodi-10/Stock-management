import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/friends_bloc.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';
import 'package:yourvone/src/models/user_model.dart';

import 'package:yourvone/src/screens/friend_detail_page.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/blocs/user_bloc.dart';
import 'package:yourvone/src/utils/utils.dart';


class FriendsListBody extends StatelessWidget{
  final FriendsBloc friendsBloc;
  final String email;
  FriendsListBody({Key key, @required this.friendsBloc, @required this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget _snackBarWidget(String message){
      return SnackBar(content: Text(message, style: TextStyle(color: Colors.white),), backgroundColor: Colors.green);
    }
    Widget createUserCard(User user){
      return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RoutesScreen.FRIEND_DETAIL, arguments: user);
            },
            child: Card(
              color: headerBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          size: 40.0,
                          color: PrimaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            user.displayName,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                      onSelected: (itemValue){
                        switch (itemValue){
                          case "removeFriend":
                            friendsBloc.unFriend(email, user.email).then((success){
                              if(success){
                                friendsBloc.fetchUserFriends(email);
                                Scaffold.of(context).showSnackBar(_snackBarWidget("${user.displayName} was removed from your friends list."));
                              }
                            });
                            break;
                        }
                      },
                      icon: Icon(Icons.more_horiz),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(child: Text("Remove Friend"), value: "removeFriend")
                        ];
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: StreamBuilder(
          stream: friendsBloc.friends,
          builder: (context, snapshot){
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return createUserCard(snapshot.data[index]);
                }
              );
            }else if( snapshot.hasError){
              return Card(
                color: headerBackgroundColor,
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(snapshot.error.toString())
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      )
    );
  }
}
