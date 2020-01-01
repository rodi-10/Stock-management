import 'package:flutter/material.dart';
import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/widgets/profile_body.dart';
import 'package:yourvone/src/widgets/profile_header.dart';

class MyProfile extends StatelessWidget {
  final User user;
  @override
  MyProfile({Key key, @required this.user}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: ListView(
            children: <Widget>[ProfileHeader(), ProfileBody(user: user,)],
          ),
        ));
  }
}
