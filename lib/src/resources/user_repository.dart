import 'dart:async';

import 'package:yourvone/src/models/user_model.dart';
import 'package:yourvone/src/resources/user_provider.dart';

class UserRepository{
  final userApiProvider = UserApiProvider();
  Future<User> getUser(String email) => userApiProvider.getUser(email);

  /// This should query Firebase storage, with the user's ID, and return a list
  /// of the IDs of the portfolio, whether they are active or archived.
  /// TODO: Freanu
  Future<List<String>> getUserPortfolios(String userID) => Future.value([]);

  /// Once you have the User object, you can get the portfolios of the user by
  /// getting the ID of the user, then using the above function to fetch portfolios.
  /// Then, you need to filter the list of portfolios to get only the active one (since past portfolios should also be returned).
}