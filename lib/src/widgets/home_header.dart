import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';


class HomeHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: headerBackgroundColor,
      width: double.infinity,
      height: getHeightByScreen(context, ratio: 0.125),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'TRADER DRAFT',
              style: TextStyle(
                  fontSize: 40.0,
                  color: PrimaryColor,
                  fontWeight: FontWeight.w300
              ),
            ),
          ),
        ],
      ),
    );
  }
}