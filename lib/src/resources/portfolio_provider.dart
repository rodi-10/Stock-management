import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'package:yourvone/src/models/portfolio_model.dart';
import 'package:yourvone/src/models/stock_search_result.dart';
import 'package:yourvone/src/utils/utils.dart';

class PortfolioApiProvider {
  Dio _dio = Dio();
  Client client = Client();

  var now = DateTime.now();
  var _db = Firestore.instance;

  PortfolioApiProvider() {
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<Stock> getStock(String stockId) async {
    try {
      var response = await _dio.get(AlphaVantageHost, queryParameters: {
        "function": AlphaVantageFunctions.getStock,
        "symbol": stockId,
        "apikey": AlphaVantageAPIKey
      });
      if (response.data['Note'] != null){
        throw new Exception(response.data['Note']);
      }
      return Stock.fromJson(response.data);
    } on DioError catch (e) {
      print('retreving stockdata error: $e');
      rethrow;
    } catch (e){
      print('stockdata parsing error: $e');
      rethrow;
    }
  }

  Future<List<BestMatch>> getSearchResult(String keyword) async {
    try {
      if (keyword.isNotEmpty) {
        var response = await _dio.get(AlphaVantageHost, queryParameters: {
          "function": AlphaVantageFunctions.symbolSearch,
          "keywords": keyword,
          "apikey": AlphaVantageAPIKey
        });
        return StockSearchResult.fromJson(response.data).bestMatches;
      } else
        return null;
    } on DioError catch (e) {
      print('stock search error: $e');
      rethrow;
    }
  }

  Future<Portfolio> getPortfolio(String userEmail) async {
    try {
      DocumentSnapshot snapShot =
          await _db.collection('users').document(userEmail).get();
      if (snapShot.data["portfolio"] != null) {
        Portfolio portfolio = Portfolio.fromJson(snapShot.data['portfolio']);
        return portfolio;
      }
      return Portfolio();
    } catch (e) {
      print('error on getPortfolio function on portfolio_provider $e');
      rethrow;
    }
  }

  Future<List<Stock>> getUserStocks(String userEmail) async {
    try {
      QuerySnapshot stocksRef = await _db
          .collection('users')
          .document(userEmail)
          .collection('stocks')
          .getDocuments();
      if (stocksRef.documents.isNotEmpty) {
        return stocksRef.documents
            .map((stockRef) => Stock.fromJsonFireBase(stockRef.data))
            .toList();
      }
      return [];
    } catch (e) {
      print('error on getUserStocks function on portfolio_provider $e');
      rethrow;
    }
  }

  Future<bool> buyStock(String userEmail, String stockId, String stockName,
      int totalCount, double finalPrice) async {
    try {
      var stockCollection = _db
          .collection('users')
          .document('$userEmail')
          .collection('stocks')
          .document('$stockId');
      var userCollection = _db.collection('users').document('$userEmail');
      bool isValid = false;
      int userStockValueCount = 0;
      double netWorth = 0;

      await userCollection.get().then((val) {
        netWorth = val.data['netWorth'].toDouble();
      });

      await stockCollection.get().then((val) {
        //create fresh collection for first time user
        //Validate if total cost is larger than current net-worth
        if (val.data != null) {
          userStockValueCount =
              (val.data['metaData']['value'] ?? 0) + totalCount;
          //Validate if total cost is larger than current net-worth
          netWorth = netWorth - (finalPrice *= userStockValueCount);
          if (netWorth >= 0) {
            stockCollection.updateData({
              'metaData': {
                'name': '$stockName',
                'symbol': '$stockId',
                'value': userStockValueCount
              }
            });
            //update field for user's net-worth
            userCollection.updateData({'netWorth': netWorth});
            isValid = true;
          }
        } else {
          //create fresh collection for first time user
          //Validate if total cost is larger than current net-worth
          netWorth = netWorth - (finalPrice *= totalCount);
          if (netWorth >= 0) {
            //create item for stock collection
            stockCollection.setData({
              'metaData': {
                'name': '$stockName',
                'symbol': '$stockId',
                'value': totalCount
              }
            });
            //update field for user's net-worth
            userCollection.updateData({'netWorth': netWorth});
            isValid = true;
          }
        }
      });
      return isValid;
    } catch (e) {
      print('There was an error buying stocks: $e');
      return false;
    }
  }

  Future<bool> sellStocks(String userEmail, String stockId, String stockName,
      int totalCount, double finalPrice) async {
    try {
      //Select query for validation if data has already a collection
      var stockCollection = _db
          .collection('users')
          .document('$userEmail')
          .collection('stocks')
          .document('$stockId');
      var userCollection = _db.collection('users').document('$userEmail');
      bool isValid = false;
      int userStockValueCount = 0;
      double netWorth = 0;

      await userCollection.get().then((val) {
        netWorth = double.tryParse('${val.data['netWorth'].toString()}');
      });

      await stockCollection.get().then((val) {
        if (val.data != null) {
          userStockValueCount =
              (val.data['metaData']['value'] ?? 0) - totalCount;
          netWorth = netWorth + (finalPrice *= totalCount);
          if (userStockValueCount > 0) {
            stockCollection.updateData({
              'metaData': {
                'name': '$stockName',
                'symbol': '$stockId',
                'value': userStockValueCount
              }
            });
            //update field for user's net-worth
            userCollection.updateData({'netWorth': netWorth});
            isValid = true;
          } else if (userStockValueCount == 0) {
            stockCollection.delete();
            //update field for user's net-worth
            userCollection.updateData({'netWorth': netWorth});
            isValid = true;
          } else {
            isValid = false;
          }
        }
      });
      return isValid;
    } catch (e) {
      print('There was an error selling stocks $e');
      return false;
    }
  }
}
