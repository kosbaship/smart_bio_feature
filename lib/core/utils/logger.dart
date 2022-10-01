import 'package:logger/logger.dart';

class LoggerUtils {
  late final Logger _logger;
  static final LoggerUtils _instance = LoggerUtils._internal(Logger());
  factory LoggerUtils() => _instance;

  LoggerUtils._internal(this._logger);

  ///view
  makeLoggerView(String print) {
    _logger.v(print);
  }

  ///debug
  makeLoggerDebug(String print) {
    _logger.d(print);
  }

  ///info message
  makeLoggerInfo(String print) {
    _logger.i(print);
  }

  ///warning
  makeLoggerWarning(String print) {
    _logger.w(print);
  }

  ///errror
  makeLoggerError(String print) {
    _logger.e(print);
  }

// LoggerUtils().makeLoggerInfo(remoteData.toJson().toString());
}
