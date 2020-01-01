import 'package:flutter/material.dart';
import 'package:yourvone/src/models/user_model.dart';

import 'package:yourvone/src/widgets/home_body.dart';
import 'package:yourvone/src/widgets/home_header.dart';


class HomePage extends StatelessWidget{
  final User user;
  HomePage({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HomeHeader(),
            HomeBody(user: user),
          ],
        ),
      ),
    );
  }
}
