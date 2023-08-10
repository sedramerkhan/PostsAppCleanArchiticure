import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoIml implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoIml(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
