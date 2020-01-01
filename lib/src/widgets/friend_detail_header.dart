import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';


class FriendDetailHeader extends StatelessWidget{
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
            GestureDetector(
              onTap: (){
                print('tapped here');
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: PrimaryColor,
                size: 30.0,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Friend',
                  style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 30.0
                  ),
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}