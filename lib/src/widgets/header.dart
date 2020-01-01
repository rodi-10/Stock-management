import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/utils/color_helper.dart';


class Header extends StatefulWidget{
  @override
  State createState() => _HeaderState();
}


class _HeaderState extends State<Header>{

  bool _appearContent = false;
  String _numberToShow = '\$3,858.06';

  void _showContent () {
    setState(() {
      _appearContent
          ? _appearContent = false
          : _appearContent = true;
    });
  }

  Widget getRowComponent(bool isLeft, String value){
    return Padding(
      padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      child: Container(
        child: Column(
          children: <Widget>[
            isLeft
                ? Icon(
              Icons.arrow_back, color: Colors.red, size: 25.0,
            )
                : Icon(
              Icons.arrow_forward, color: Colors.green, size: 25.0,
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getPricesRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getRowComponent(true, '\$1,399.79'),
        VerticalDivider(
          width: 2.0, color: Colors.grey,
        ),
        getRowComponent(false, '\$1,843.25'),
      ],
    );
  }

  Widget getMessageRow(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(), // some icons here based on layout
          Text(
            'Loren ipsum dolor sit amet.',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20.0,
                fontWeight: FontWeight.w400
            ),
          ),
          Icon(
            Icons.settings, color: Colors.grey,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              color: headerBackgroundColor,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appearContent
                        ? GestureDetector(
                      child: Icon(Icons.keyboard_arrow_left, color: PrimaryColor,),
                      onTap: _showContent,
                    )
                        : Icon(Icons.account_box, color: PrimaryColor, size: 30.0,),
                    Column(
                      children: <Widget>[
                        Text(
                          _numberToShow,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 27.0,
                              color: PrimaryColor
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                              Icons.keyboard_arrow_down,
                              color: _appearContent
                                  ? headerBackgroundColor
                                  : headerArrowColor
                          ),
                          onTap: _showContent,
                        ),
                      ],
                    ),
                    Icon(Icons.border_color, color: PrimaryColor)
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Column(
                children: <Widget>[
                  Divider(),
                  getPricesRow(),
                  Divider(),
                  getMessageRow()
                ],
              ),
              height: _appearContent
                  ? getHeightByScreen(context, ratio: 0.20)
                  : 0.0,
              color: headerBackgroundColor,
              width: double.infinity,
            )
          ],
        )
    );
  }
}
