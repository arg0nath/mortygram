import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mortygram/config/logger/log_level.dart';
import 'package:mortygram/core/common/constants/app_const.dart';

/// Prints log output to the console.
///
/// [level] is the type of message.
///
/// [msg] is the message to be printed in console.
///
/// Returns void. Debuging purposes only.
void myLog(String msg, {LogLevel? level = .info}) {
  if (kDebugMode) {
    level ??= .info;
    if (AppConst.showLog) {
      if (level == .info) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}: $msg');
      } else if (level == .warning) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${AppConst.logWarningColor}: $msg ${AppConst.logResetColor}');
      } else if (level == .error) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${AppConst.logErrorColor}: 🚫 ERROR: $msg 🚫 ${AppConst.logResetColor}');
      } else {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${AppConst.logWtfColor}: WTF:  $msg${AppConst.logResetColor}');
      }
    }
  }
}
