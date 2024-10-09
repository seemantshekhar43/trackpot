import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class NetworkConnectionChecker {
  Future<bool> get isConnected;
}

class NetworkConnectionCheckerImpl implements NetworkConnectionChecker {
  final InternetConnection internetConnection;
  NetworkConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}