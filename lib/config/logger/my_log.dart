import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mortygram/config/logger/log_level.dart';

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

    if (level == .info) {
      log('${DateFormat('HH:mm:ss').format(DateTime.now())}: $msg');
    } else if (level == .warning) {
      log('${DateFormat('HH:mm:ss').format(DateTime.now())}-$_logWarningColor: $msg $_logResetColor');
    } else if (level == .error) {
      log('${DateFormat('HH:mm:ss').format(DateTime.now())}-$_logErrorColor: 🚫 ERROR: $msg 🚫 $_logResetColor');
    } else {
      log('${DateFormat('HH:mm:ss').format(DateTime.now())}-$_logWtfColor: WTF:  $msg$_logResetColor');
    }
  }
}

const String _logResetColor = '\u001b[0m';
const String _logErrorColor = '\u001b[31m';
const String _logWarningColor = '\u001b[32m';
const String _logWtfColor = '\u001b[36;1m';
