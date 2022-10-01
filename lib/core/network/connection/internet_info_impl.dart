import 'package:connectivity_plus/connectivity_plus.dart';
part 'internet_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Future<ConnectivityResult> dataConnectionChecker;

  NetworkInfoImpl({required this.dataConnectionChecker});

  @override
  Future<bool> get isConnected =>
      dataConnectionChecker.then((connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          return true;
        } else {
          return false;
        }
      });
}