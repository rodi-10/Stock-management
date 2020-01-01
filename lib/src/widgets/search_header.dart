import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';


class SearchHeader extends StatefulWidget{
  @override
  State createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader>{

  Widget getFirstRow(){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.arrow_back_ios, color: PrimaryColor, size: 24.0),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Crypto',
              style: TextStyle(
                fontSize: 34.0,
                color: PrimaryColor,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
          Icon(Icons.attach_money, color: PrimaryColor, size: 24.0)
        ],
      ),
    );
  }

  Widget getSearchRow(){
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.search),
          Text('Search')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    double allowableHeight = getHeightByScreen(context, ratio: 0.175);
    return Container(
      height: allowableHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: headerBackgroundColor,
        boxShadow: [BoxShadow(
          color: Colors.black12,
          spreadRadius: 5,
          blurRadius: 3
        )]
      ),
      child: Column(
        children: <Widget>[
          getFirstRow(),
          getHeaderDivider(),
          getSearchRow()
        ],
      ),
    );
  }
}
