import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';
import 'package:yourvone/src/models/portfolio_model.dart';

import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/utils/utils.dart';
import 'package:yourvone/src/widgets/stock_detail_barchart.dart';
import 'package:yourvone/src/widgets/stock_detail_candlestick.dart';


class StockDetailInfo extends StatefulWidget {
  List<dynamic> timeSeriesList;
  StockDetailInfo({Key key, @required this.timeSeriesList}) : super(key: key);

  @override
  _StockDetailInfoState createState() => _StockDetailInfoState();
}


class _StockDetailInfoState extends State<StockDetailInfo> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
        child: ListView(
          children: <Widget>[
            getBarGraph(context),
            getStatsComponent(context),
            //getCandleStickGraph(context),
          ],
        )
    );
  }

  Widget getBarGraph(BuildContext context){
    double barGraphIconWidthHeight = getHeightByScreen(context, ratio: 0.06);
    return Container(
      height: getHeightByScreen(context, ratio: 0.40),
      decoration: BoxDecoration(
        color: PrimaryColor,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: StockPriceBarChart(widget.timeSeriesList),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: barGraphIconWidthHeight,
                    width: barGraphIconWidthHeight,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.av_timer),
                    ),
                  ),
                  onTap: (){ // TODO: add some function/action to this button
                    print('pressed button');
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: GestureDetector(
                    child: Container(
                      height: barGraphIconWidthHeight,
                      width: barGraphIconWidthHeight,
                      decoration: BoxDecoration(
                          color: Colors.blue
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.cloud_circle),
                      ),
                    ),
                    onTap: (){ // TODO: add some function/action to this button
                      print('pressed button');
                    },
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: barGraphIconWidthHeight,
                    width: barGraphIconWidthHeight,
                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.timer),
                    ),
                  ),
                  onTap: (){// TODO: add some function/action to this button
                    print('pressed button');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getStatsComponent(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: PrimaryColor
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 20.0, 15.0, 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '0.13%', // TODO: should be dynamic
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        'TODAY',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        )
                    ),
                  ),
                ),
                Text(
                  '1.65', // TODO: should be dynamic
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300
                  ),
                )
              ],
            ),
          ),
          getHeaderDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 20.0, 15.0, 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '1344.69', // TODO: should be dynamic
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        'LOW / HIGH',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        )
                    ),
                  ),
                ),
                Text(
                  '1361.99', // TODO: should be dynamic
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300
                  ),
                )
              ],
            ),
          ),
          getHeaderDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 20.0, 15.0, 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '61 %', // TODO: should be dynamic
                  style: TextStyle(
                      color: redDetailInfoComp,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        'SELLERS / BUYERS',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        )
                    ),
                  ),
                ),
                Text(
                  '39 %', // TODO: should be dynamic
                  style: TextStyle(
                      color: greenDetailInfoComp,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                color: redDetailInfoComp,
                height: 5.0,
                width: getWidthByScreen(context, ratio: 0.605),
              ),
              Container(
                width: getWidthByScreen(context, ratio: 0.01),
              ),
              Container(
                color: greenDetailInfoComp,
                height: 5.0,
                width: getWidthByScreen(context, ratio: 0.385),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getCandleStickGraph(BuildContext context){ // FIXME: basically copied from bargraph. may be recycled, perhaps?
    double barGraphIconWidthHeight = getHeightByScreen(context, ratio: 0.06);
    return Container(
      height: getHeightByScreen(context, ratio: 0.50),
      decoration: BoxDecoration(
          color: PrimaryColor
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: StockDetailCandlestick(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: barGraphIconWidthHeight,
                    width: barGraphIconWidthHeight,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.av_timer),
                    ),
                  ),
                  onTap: (){ // TODO: add some function/action to this button
                    print('pressed button');
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: GestureDetector(
                    child: Container(
                      height: barGraphIconWidthHeight,
                      width: barGraphIconWidthHeight,
                      decoration: BoxDecoration(
                          color: Colors.blue
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.cloud_circle),
                      ),
                    ),
                    onTap: (){ // TODO: add some function/action to this button
                      print('pressed button');
                    },
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: barGraphIconWidthHeight,
                    width: barGraphIconWidthHeight,
                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.timer),
                    ),
                  ),
                  onTap: (){// TODO: add some function/action to this button
                    print('pressed button');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
