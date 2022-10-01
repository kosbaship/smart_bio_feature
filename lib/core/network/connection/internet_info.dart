part of 'internet_info_impl.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
