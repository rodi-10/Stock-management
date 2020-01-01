import 'package:flutter/material.dart';
import 'package:yourvone/src/models/user_model.dart';

import 'package:yourvone/src/widgets/friend_detail_header.dart';
import 'package:yourvone/src/widgets/friend_detail_body.dart';


class FriendDetailPage extends StatelessWidget{

  // added an attribute '_userId' here on detail page, since we need to get a particular user
  final User user;
  FriendDetailPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FriendDetailHeader(),
            FriendDetailBody(user: user)
          ],
        ),
      ),
    );
  }
}