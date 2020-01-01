import 'package:rxdart/rxdart.dart';

import 'package:yourvone/src/models/portfolio_model.dart';
import 'package:yourvone/src/models/stock_search_result.dart';
import 'package:yourvone/src/resources/portfolio_repository.dart';
import 'package:yourvone/src/utils/utils.dart';

class PortfolioBloc {
  final _repository = PortfolioRepository();
  final _portfolioFetcher = BehaviorSubject<Portfolio>();
  final _isSearchFieldFetcher = BehaviorSubject<bool>();
  final _bestmatchFetcher = BehaviorSubject<List<BestMatch>>();
  final _stocksFetcher = BehaviorSubject<List<Stock>>();

  Observable<Portfolio> get portfolio => _portfolioFetcher.stream;
  Observable<List<BestMatch>> get bestMatches => _bestmatchFetcher.stream;
  Observable<bool> get isSearchField => _isSearchFieldFetcher.stream;
  Observable<List<Stock>> get stocks => _stocksFetcher.stream;

  PortfolioBloc(){
    _isSearchFieldFetcher.add(false);
    _bestmatchFetcher.add(popularStocks);
  }

  Observable<String> getPortfolioNetWorth(String portfolioId){
    var returnObject = Stream.fromFuture(_repository.getPortfolio(portfolioId))
        .expand((portfolio) {
      return portfolio.stocks;
    }).transform(new FlatMapStreamTransformer((stock) {
      return getStockValue(stock.metaData.symbol);
    })).reduce((accumulator, current) {
      return accumulator + current;
    }).catchError((error) => 0.0);

    return Observable.fromFuture(returnObject)
        .handleError((error){
        return Observable.just(0.0);
    });

//    returnObject.asStream().first.then((result){
//      print(result);
//    });

//    return Observable.just(1500);
//        .doOnData((double close){
//          var temp = close + 1;
//        })
//        .doOnError((error){
//          print(error);
//        })
//        .doOnDone((){
//          print('success!');
//        });

//      return Observable.fromFuture(
//          Stream.fromIterable([1.1,2.1,3.1])
//              .reduce((x, y) => x + y)
//      );
  }

  fetchSearchResult(String keyword){
    if(keyword.isNotEmpty){
      _bestmatchFetcher.add(null);
      _repository.getSearchResult(keyword).then((resultList){
        _bestmatchFetcher.add(resultList);
      });
    } else {
      _bestmatchFetcher.add(popularStocks);
    }
  }

//  Observable<double> getPortfolioEndGameNetworth(String portfolioId) {
//    // TODO: add functionality
//  }

  Observable<Stock> getStockData(String stockId) {
    return Observable.fromFuture(_repository.getStock(stockId));
  }

  Observable<String> getStockValue(String stockId) {
    return getStockData(stockId).map((stock) => stock.timeSeriesDaily[formatDateNow(DateTime.now())].close)
      .handleError((error) => 0.0);
  }

  void toggleSearchField(bool toggleStatus){
    if(toggleStatus){
      _isSearchFieldFetcher.add(false);
    } else {
      _isSearchFieldFetcher.add(true);
    }
  }

  void fetchPortfolio(String email) async {
    Portfolio portfolio = await _repository.getPortfolio(email);
    _portfolioFetcher.sink.add(portfolio);
  }

  void fetchUserStocks(String userEmail) async{
    List<Stock> stocks = await _repository.getUserStocks(userEmail);
    _stocksFetcher.sink.add(stocks);
  }

  List<BestMatch> popularStocks = [
    BestMatch(symbol: 'FB', name:'Facebook'),
    BestMatch(symbol: 'APL', name:'Apple'),
    BestMatch(symbol: 'AMZN', name:'Amazon'),
    BestMatch(symbol: 'TWTR', name:'Twitter'),
    BestMatch(symbol: 'NDAQ', name:'Nasdaq Inc.'),
    BestMatch(symbol: 'MSFT', name:'Microsoft'),
    BestMatch(symbol: 'JAPAY', name:'Japan Tobacco Inc.'),
    BestMatch(symbol: 'DELL', name:'Dell Technologies Inc.'),
    BestMatch(symbol: 'DOW', name:'Dow Inc.'),
    BestMatch(symbol: 'TSLA', name:'Tesla Inc.'),
  ];

  dispose() {
    _portfolioFetcher.close();
    _bestmatchFetcher.close();
    _isSearchFieldFetcher.close();
    _stocksFetcher.close();
  }
}
