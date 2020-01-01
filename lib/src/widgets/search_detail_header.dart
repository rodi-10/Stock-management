import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';


class SearchDetailHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: PrimaryColor, size: 24.0)
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Details',
              style: TextStyle(
                  fontSize: 34.0,
                  color: PrimaryColor,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
          Icon(Icons.monetization_on, color: PrimaryColor, size: 24.0)
        ],
      ),
    );
  }
}