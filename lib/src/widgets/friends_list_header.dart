import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';


class FriendsListHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
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
                'Friends',
                style: TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 30.0
                ),
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Icon(
                Icons.search,
                color: PrimaryColor,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}