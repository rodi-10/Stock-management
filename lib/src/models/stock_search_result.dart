// To parse this JSON data, do
//
//     final stockSearchResult = stockSearchResultFromJson(jsonString);

import 'dart:convert';

StockSearchResult stockSearchResultFromJson(String str) => StockSearchResult.fromJson(json.decode(str));

String stockSearchResultToJson(StockSearchResult data) => json.encode(data.toJson());

class StockSearchResult {
  List<BestMatch> bestMatches;

  StockSearchResult({
    this.bestMatches,
  });

  factory StockSearchResult.fromJson(Map<String, dynamic> json) => StockSearchResult(
    bestMatches: json["bestMatches"] == null ? null : List<BestMatch>.from(json["bestMatches"].map((x) => BestMatch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bestMatches": bestMatches == null ? null : List<dynamic>.from(bestMatches.map((x) => x.toJson())),
  };
}

class BestMatch {
  String symbol;
  String name;
  String type;
  String region;
  String marketOpen;
  String marketClose;
  String timeZone;
  String currency;
  String matchScore;

  BestMatch({
    this.symbol,
    this.name,
    this.type,
    this.region,
    this.marketOpen,
    this.marketClose,
    this.timeZone,
    this.currency,
    this.matchScore,
  });

  factory BestMatch.fromJson(Map<String, dynamic> json) => BestMatch(
    symbol: json["1. symbol"] == null ? null : json["1. symbol"],
    name: json["2. name"] == null ? null : json["2. name"],
    type: json["3. type"] == null ? null : json["3. type"],
    region: json["4. region"] == null ? null : json["4. region"],
    marketOpen: json["5. marketOpen"] == null ? null : json["5. marketOpen"],
    marketClose: json["6. marketClose"] == null ? null : json["6. marketClose"],
    timeZone: json["7. timezone"] == null ? null : json["7. timezone"],
    currency: json["8. currency"] == null ? null : json["8. currency"],
    matchScore: json["9. matchScore"] == null ? null : json["9. matchScore"],
  );

  Map<String, dynamic> toJson() => {
    "1. symbol": symbol == null ? null : symbol,
    "2. name": name == null ? null : name,
    "3. type": type == null ? null : type,
    "4. region": region == null ? null : region,
    "5. marketOpen": marketOpen == null ? null : marketOpen,
    "6. marketClose": marketClose == null ? null : marketClose,
    "7. timezone": timeZone == null ? null : timeZone,
    "8. currency": currency == null ? null : currency,
    "9. matchScore": matchScore == null ? null : matchScore,
  };
}
