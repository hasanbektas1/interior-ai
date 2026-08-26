import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as x;

enum LogLevel { info, warning, error }

final class AppLogger {
  static final AppLogger instance = AppLogger._();
  AppLogger._();

  /// Prints message according to log level
  void log(String message, {LogLevel level = LogLevel.info}) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = "[$timestamp] [${level.name.toUpperCase()}] $message";

    if (kDebugMode) {
      // Print directly to screen in debug mode
      print(logMessage);
      x.log(logMessage);
    } else {
      // Save to log file in Production mode
      _writeLogToFile(logMessage);
      x.log(logMessage);
    }
  }

  /// Manages error logs privately
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: LogLevel.error);
    if (error != null) {
      log("Error Details: $error", level: LogLevel.error);
    }
    if (stackTrace != null) {
      log("StackTrace: $stackTrace", level: LogLevel.error);
    }
  }

  /// Largest the on-device log file is allowed to grow before it's reset, so it
  /// never accumulates without bound across the app's lifetime.
  static const int _maxLogBytes = 256 * 1024;

  /// Save logs to a file
  Future<void> _writeLogToFile(String message) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_logs.txt');
      // Reset the file once it exceeds the cap instead of appending forever.
      final mode = (await file.exists() && await file.length() > _maxLogBytes)
          ? FileMode.write
          : FileMode.append;
      await file.writeAsString("$message\n", mode: mode);
    } catch (e) {
      // Never call log() here — in release that would recurse back into
      // _writeLogToFile. Route the failure straight to the dev channel.
      x.log("Failed to write to log file: $e");
    }
  }

  /// Clears the log file
  Future<void> clearLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_logs.txt');
      if (await file.exists()) {
        await file.writeAsString(""); // Cleans up by typing empty content
      }
    } catch (e) {
      log("Error clearing log file: $e", level: LogLevel.error);
    }
  }

  /// Reads the log file
  Future<String?> readLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_logs.txt');
      if (await file.exists()) {
        return await file.readAsString();
      }
    } catch (e) {
      log("Error clearing log file: $e", level: LogLevel.error);
    }
    return null;
  }
}
