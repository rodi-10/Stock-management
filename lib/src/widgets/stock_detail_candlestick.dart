import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';


List sampleData = [
  {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
  {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
  {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
  {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
  {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
  {"open":75.0, "high":105.0, "low":70.0, "close":85, "volumeto":5000.0},
  {"open":80.0, "high":93.0, "low":65.0, "close":55, "volumeto":4000.0},
  {"open":85.0, "high":113.0, "low":70.0, "close":80, "volumeto":7000.0},
  {"open":90.0, "high":105.0, "low":55.0, "close":95, "volumeto":2000.0},
  {"open":90.0, "high":103.0, "low":50.0, "close":70, "volumeto":3000.0},
  {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
  {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
  {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
  {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
  {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
  {"open":75.0, "high":105.0, "low":70.0, "close":85, "volumeto":5000.0},
  {"open":80.0, "high":93.0, "low":65.0, "close":55, "volumeto":4000.0},
  {"open":85.0, "high":113.0, "low":70.0, "close":80, "volumeto":7000.0},
  {"open":90.0, "high":105.0, "low":55.0, "close":95, "volumeto":2000.0},
  {"open":90.0, "high":103.0, "low":50.0, "close":70, "volumeto":3000.0},
  {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
  {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
  {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
  {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
  {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
  {"open":75.0, "high":105.0, "low":70.0, "close":85, "volumeto":5000.0},
  {"open":80.0, "high":93.0, "low":65.0, "close":55, "volumeto":4000.0},
  {"open":85.0, "high":113.0, "low":70.0, "close":80, "volumeto":7000.0},
  {"open":90.0, "high":105.0, "low":55.0, "close":95, "volumeto":2000.0},
  {"open":90.0, "high":103.0, "low":50.0, "close":70, "volumeto":3000.0},
  {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
  {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
  {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
  {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
  {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
  {"open":75.0, "high":105.0, "low":70.0, "close":85, "volumeto":5000.0},
  {"open":80.0, "high":93.0, "low":65.0, "close":55, "volumeto":4000.0},
  {"open":85.0, "high":113.0, "low":70.0, "close":80, "volumeto":7000.0},
  {"open":90.0, "high":105.0, "low":55.0, "close":95, "volumeto":2000.0},
  {"open":90.0, "high":103.0, "low":50.0, "close":70, "volumeto":3000.0},
  {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
  {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
  {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
  {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
  {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
  {"open":75.0, "high":105.0, "low":70.0, "close":85, "volumeto":5000.0},
  {"open":90.0, "high":103.0, "low":50.0, "close":70, "volumeto":3000.0},
  {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
  {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
  {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
  {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
  {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
  {"open":75.0, "high":105.0, "low":70.0, "close":85, "volumeto":5000.0},
];

class StockDetailCandlestick extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      child: OHLCVGraph(
          data: sampleData,
          enableGridLines: true,
          volumeProp: 0.05,
          gridLineAmount: 5,
          gridLineColor: Colors.grey[300],
          gridLineLabelColor: Colors.grey
      )
    );
  }
}