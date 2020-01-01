import 'package:flutter/material.dart';

import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/utils/color_helper.dart';


class SearchDetailBody extends StatelessWidget{

  Widget getUpperBodyListTile(String category1, String value, String category2, String value2){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: <Widget>[
                Text(
                  category1,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: <Widget>[
                Text(
                  category2,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    value2,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getLowerBodyListTile(String category1, String value1, bool isUp, String category2, String value2, bool isUp2){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: <Widget>[
                Text(
                  category1,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    value1,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        color: isUp
                                ? greenUpPositive
                                : redDownNegative
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: <Widget>[
                Text(
                  category2,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    value2,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        color: isUp2
                            ? greenUpPositive
                            : redDownNegative
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: PrimaryColor
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getUpperBodyListTile('Name', '\$UK100', 'Full Name', '\$FTSE'),
              getUpperBodyListTile('Market Name', 'UK Indices', 'Currency', 'GBP'),
              getUpperBodyListTile('Min Traded Quantity', 'One', 'Spread Type', 'Floating'),
              getUpperBodyListTile('Spread Type', 'Floating', 'Target Spread', '1.0'),
              getUpperBodyListTile('Margin', '0.5%', 'Short Position Swap', '-0.396656'),
              getUpperBodyListTile('Long Position Swap', '-0.594983', 'Swap Time', '00:00:00'),
              SizedBox(height: 50.0,),
              getLowerBodyListTile('Week', '+0.46%', true, '1 Month', '-1.08%', false),
              getLowerBodyListTile('3 Months', '-4.23%', false, '6 Months', '+0.13', true),
              getLowerBodyListTile('Year', '-2.98%', false, '2 Years', '-3.56', false),
              getLowerBodyListTile('3 Years', '-5.34%', false, '4 Years', '-6.67', false),
              getLowerBodyListTile('5 Years', '5.34%', true, '6 Years', '6.67', true),
              getLowerBodyListTile('Year', '-2.98%', false, '2 Years', '-3.56', false),
              getLowerBodyListTile('3 Years', '-5.34%', false, '4 Years', '-6.67', false),
              getLowerBodyListTile('5 Years', '5.34%', true, '6 Years', '6.67', true)
            ],
          ),
        ),
      ),
    );
  }
}