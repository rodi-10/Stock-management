import 'package:flutter/material.dart';
import 'package:yourvone/src/blocs/portfolio_bloc.dart';
import 'package:yourvone/src/models/stock_search_result.dart';
import 'package:yourvone/src/utils/color_helper.dart';
import 'package:yourvone/src/screens/stock_detail_view.dart';



class StocksPageList extends StatefulWidget{
  final PortfolioBloc portfolioBloc;
  StocksPageList({Key key, @required this.portfolioBloc}) : super(key: key);
  @override
  State createState() => _StocksPageListState();
}


class _StocksPageListState extends State<StocksPageList>{

  Widget createHomeListTile(String symbol, String name){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StockDetailView(symbol: symbol,name: name))
        );
        /*showDialog(context: context,builder: (BuildContext context){
         return AddStock(id: iconTitle, name: title,);
        },);*/
      },
      child: Container(
//        color: headerBackgroundColor,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(symbol, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: 200),child: Text(name, textAlign: TextAlign.end, style: TextStyle(fontSize: 18),)),
              ],
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: StreamBuilder<bool>(
        stream: widget.portfolioBloc.isSearchField,
        builder: (context, searchFieldSnapshot) {
          if (searchFieldSnapshot.hasData){
            if(searchFieldSnapshot.data){
              return StreamBuilder<List<BestMatch>>(
                  stream: widget.portfolioBloc.bestMatches,
                  builder: (context, bestMatchSnapshot) {
                    if(bestMatchSnapshot.hasData){
                      if(bestMatchSnapshot.data.length != 0){
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Visibility(
                                visible: true,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                  child: Text("Popular Stocks", style: TextStyle(color: PrimaryColor, fontWeight: FontWeight.bold),),
                                ),
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: bestMatchSnapshot.data.length,
                                  itemBuilder: (context, index){
                                    return createHomeListTile(bestMatchSnapshot.data[index].symbol, bestMatchSnapshot.data[index].name);
                                  }
                              )
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.info, size: 50,),
                              SizedBox(height: 20,),
                              Text("No Match", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white30),),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                        child: Text("Popular Stocks", style: TextStyle(color: PrimaryColor, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.portfolioBloc.popularStocks.length,
                      itemBuilder: (context, index){
                        return createHomeListTile(widget.portfolioBloc.popularStocks[index].symbol, widget.portfolioBloc.popularStocks[index].name);
                      }
                    )
                  ],
                ),
              );
            }
          } else {
            return Container();
          }
        }
      ),
    );
  }

}
