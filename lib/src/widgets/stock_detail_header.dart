import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yourvone/src/models/portfolio_model.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/widgets/UpdateStock.dart';

class DetailViewHeader extends StatelessWidget {
  final String symbol;
  final String name;
  final double finalPrice;
  DetailViewHeader(
      {Key key,
      @required this.symbol,
      @required this.name,
      @required this.finalPrice})
      : super(key: key);

  Widget getTopHeaderComponent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: PrimaryColor,
            ),
            onTap: () => Navigator.pop(context),
          ),
          Text(
            '$name',
            style: TextStyle(
                color: PrimaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 30.0),
          ),
          Icon(Icons.account_balance,
              color: PrimaryColor) // FIXME: icon not the same with sketch file
        ],
      ),
    );
  }

  Widget getPriceComponent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Sell'),
                    onPressed: () {
                      showDialog(context: context,child: UpdateStock(symbol: symbol,name: name,finalPrice: finalPrice,forBuy: false,));
                    },
                    color: Colors.red,
                  ),
                 /* Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      '1318.98', // FIXME: price should be dynamic
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  )*/
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[900], width: 0.25)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.white30,
                  ),
                  Text(
                    '39', // FIXME: text should be dynamic
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Buy'),
                    onPressed: () {
                      showDialog(context: context,child: UpdateStock(symbol: symbol,name: name,finalPrice: finalPrice,forBuy: true,));
                    },
                    color: Colors.green,
                  ),
                 /* Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      '1319.17', // FIXME: price should be dynamic
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getBottomRow() {
    return Container(
      width: 200,
      child: Column(
        children: <Widget>[
          Text('Closed Price'),
          Text(
            '${finalPrice ?? '....'}',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: headerBackgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
        ],
      ),
      child: Column(
        children: <Widget>[
          getTopHeaderComponent(context),
          getHeaderDivider(),
          getPriceComponent(context),
          getHeaderDivider(),
          getBottomRow()
        ],
      ),
    );
  }
}
