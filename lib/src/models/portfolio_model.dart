import 'dart:convert';

class Portfolio {
  String portfolioId;
  String seasonId;
  DateTime createdAt;
  double endGameNetWorth;
  List<Stock> stocks;

  Portfolio({
    this.portfolioId,
    this.stocks,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
    portfolioId: json["portfolioId"] == null ? null : json["portfolioId"],
    stocks: json["stocks"] == null ? null : List<Stock>.from(json["stocks"].map((x) => Stock.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "portfolioId": portfolioId == null ? null : portfolioId,
    "stocks": stocks == null ? null : List<dynamic>.from(stocks.map((x) => x.toJson())),
  };
}

class Stock {
  MetaData metaData;
  Map<String, TimeSeriesDaily> timeSeriesDaily;

  Stock({
    this.metaData,
    this.timeSeriesDaily,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    metaData: json["Meta Data"] == null ? null : MetaData.fromJson(json["Meta Data"]),
    timeSeriesDaily: json["Time Series (Daily)"] == null ? null : Map.from(json["Time Series (Daily)"]).map((k, v) => MapEntry<String, TimeSeriesDaily>(k, TimeSeriesDaily.fromJson(v))),
  );
  factory Stock.fromJsonFireBase(Map<dynamic, dynamic> json) => Stock(
    metaData: json["metaData"] == null ? null : MetaData.fromJsonFireBase(json["metaData"]),
    timeSeriesDaily: json["timeSeriesDaily"] == null ? null : Map.from(json["timeSeriesDaily"]).map((k, v) => MapEntry<String, TimeSeriesDaily>(k, TimeSeriesDaily.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "metaData": metaData == null ? null : metaData.toJson(),
    "timeSeriesDaily": timeSeriesDaily == null ? null : Map.from(timeSeriesDaily).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class MetaData {
  String information;
  String name;
  String symbol;
  DateTime lastRefreshed;
  String outputSize;
  String timeZone;
  double value;

  MetaData({
    this.information,
    this.symbol,
    this.lastRefreshed,
    this.outputSize,
    this.timeZone,
    this.value,
    this.name
  });

  factory MetaData.fromJson(Map<dynamic, dynamic> json) => MetaData(
    information: json["1. Information"] == null ? null : json["1. Information"],
    symbol: json["2. Symbol"] == null ? null : json["2. Symbol"],
    lastRefreshed: json["3. Last Refreshed"] == null ? null : DateTime.parse(json["3. Last Refreshed"]),
    outputSize: json["4. Output Size"] == null ? null : json["4. Output Size"],
    timeZone: json["5. Time Zone"] == null ? null : json["5. Time Zone"],
  );

  factory MetaData.fromJsonFireBase(Map<dynamic, dynamic> json) => MetaData(
    information: json["information"] == null ? null : json["information"],
    symbol: json["symbol"] == null ? null : json["symbol"],
    lastRefreshed: json["lastRefreshed"] == null ? null : DateTime.parse(json["lastRefreshed"]),
    outputSize: json["outputSize"] == null ? null : json["outputSize"],
    timeZone: json["timeZone"] == null ? null : json["timeZone"],
    value: json["value"] == null ? null : json["value"].toDouble(),
    name: json["name"] == null ? null : json["name"],

  );

  Map<String, dynamic> toJson() => {
    "information": information == null ? null : information,
    "symbol": symbol == null ? null : symbol,
    "lastRefreshed": lastRefreshed == null ? null : "${lastRefreshed.year.toString().padLeft(4, '0')}-${lastRefreshed.month.toString().padLeft(2, '0')}-${lastRefreshed.day.toString().padLeft(2, '0')}",
    "outputSize": outputSize == null ? null : outputSize,
    "timeZone": timeZone == null ? null : timeZone,
    "name": name == null ? null : name,
    "value": value == null ? null : value
  };
}

class TimeSeriesDaily {
  String open;
  String high;
  String low;
  String close;
  String volume;

  TimeSeriesDaily({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
  });

  factory TimeSeriesDaily.fromJson(Map<String, dynamic> json) => TimeSeriesDaily(
    open: json["1. open"] == null ? null : json["1. open"],
    high: json["2. high"] == null ? null : json["2. high"],
    low: json["3. low"] == null ? null : json["3. low"],
    close: json["4. close"] == null ? null : json["4. close"],
    volume: json["5. volume"] == null ? null : json["5. volume"],
  );

  Map<String, dynamic> toJson() => {
    "open": open == null ? null : open,
    "high": high == null ? null : high,
    "low": low == null ? null : low,
    "close": close == null ? null : close,
    "volume": volume == null ? null : volume,
  };
}

