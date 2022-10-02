import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

mixin LogMixin {
  void logDebug(String message) {
    if (kDebugMode) {
      print('${runtimeType.toString()}: $message');
    }
  }

  void logError(String message) {
    if (kDebugMode) {
      printError(info: '${runtimeType.toString()}: $message');
    }
  }
}
