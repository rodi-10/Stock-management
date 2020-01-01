import 'dart:async';

import 'package:yourvone/src/models/portfolio_model.dart';
import 'package:yourvone/src/models/stock_search_result.dart';
import 'package:yourvone/src/resources/portfolio_provider.dart';


class PortfolioRepository{
  final portfolioApiProvider = PortfolioApiProvider();
  Future<Portfolio> getPortfolio(String userEmail) => portfolioApiProvider.getPortfolio(userEmail);
  Future<List<Stock>> getUserStocks(String userEmail) => portfolioApiProvider.getUserStocks(userEmail);
  Future<Stock> getStock(String stockId) => portfolioApiProvider.getStock(stockId);
  Future<bool> buyStocks(String userEmail, String stockId, String stockName,int totalCount,double finalPrice) => portfolioApiProvider.buyStock(userEmail, stockId, stockName,totalCount, finalPrice);
  Future<bool> sellStocks(String userEmail, String stockId, String stockName,int totalCount,double finalPrice) => portfolioApiProvider.sellStocks(userEmail, stockId, stockName,totalCount,finalPrice);
  Future<List<BestMatch>> getSearchResult(String keyword) => portfolioApiProvider.getSearchResult(keyword);
}
