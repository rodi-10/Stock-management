import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:yourvone/src/models/detail_page_stockprice.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate = true});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}

class StockPriceBarChart extends StatefulWidget{
  final List<dynamic> chartData;
  StockPriceBarChart(this.chartData);

  @override
  State createState() => _StockPriceBarChartState();
}

class _StockPriceBarChartState extends State<StockPriceBarChart>{
  final mockData = [

  ];
  //DetailStockPrice('FEB 25', 100.43),

  getChartsData(){
    //print(widget.chartData[0].close.toString());
  }

  List<charts.Series<DetailStockPrice, String>> mapChartData(
      List<DetailStockPrice> data) {
    return [
      charts.Series<DetailStockPrice, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (DetailStockPrice sales, _) => sales.time,
        measureFn: (DetailStockPrice sales, _) => sales.price,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    getChartsData();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SimpleBarChart(mapChartData(mockData)),
    );
  }
}
