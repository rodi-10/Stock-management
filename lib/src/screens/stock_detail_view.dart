import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yourvone/src/models/detail_page_stockprice.dart';
import 'package:yourvone/src/models/portfolio_model.dart';
import 'package:yourvone/src/resources/portfolio_provider.dart';
import 'package:yourvone/src/utils/utils.dart';

import 'package:yourvone/src/widgets/stock_detail_header.dart';
import 'package:yourvone/src/widgets/stock_detail_info.dart';

class StockDetailView extends StatefulWidget {
  final String symbol;
  final String name;
  StockDetailView({Key key, @required this.symbol, @required this.name}) : super(key: key);

  @override
  _StockDetailViewState createState() => _StockDetailViewState();
}

class _StockDetailViewState extends State<StockDetailView> {
  double finalPrice = 0;
  List<dynamic> timeSeriesDailyList;
  var chartModelData = [];
  var _portfolioProvider = PortfolioApiProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStock();
  }

   getStock() async {
    await _portfolioProvider.getStock('${widget.symbol}').then((val){
      setState(() {
        //remove subtract
        /*finalPrice = double.tryParse('${val.timeSeriesDaily[formatDateNow(DateTime.now().subtract(new Duration(days: 1)))].close}');*/
        //Created global list to pass in details info and Detail Header
        timeSeriesDailyList = new List<dynamic>.from(val.timeSeriesDaily.values);
        finalPrice = double.tryParse(timeSeriesDailyList.elementAt(0).close);
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[900],
        ),
        child: Column(
          children: <Widget>[
            DetailViewHeader(symbol: widget.symbol, name: widget.name,finalPrice: finalPrice,),
            //TODO: Need to update for passing parameters.
            //StockDetailInfo(timesDailyList: timeSeriesDailyList),
          ],
        ),
      ),
    ));
  }
}
