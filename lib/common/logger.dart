import 'dart:developer';

abstract class Log {
  static void i(String tag, dynamic msg) {
    log(
      "[i][$tag] --> $msg",
      level: 800, // Informational level
      name: tag,
    );
  }

  static void d(String tag, dynamic msg) {
    log(
      "[d][$tag] --> $msg",
      level: 700, // Debug level
      name: tag,
    );
  }

  static void e(String tag, dynamic msg, {StackTrace? stackTrace}) {
    log(
      "[e][$tag] --> $msg",
      level: 1000, // Error level
      name: tag,
      stackTrace: stackTrace,
    );
  }

  static void w(String tag, dynamic msg) {
    log(
      "[w][$tag] --> $msg",
      level: 900, // Warning level
      name: tag,
    );
  }

  static void q(dynamic string) {
    log(
      string.toString(),
      level: 500, // Verbose level
    );
  }
}
