
import 'marvelflutter_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
class Marvelflutter {
  Future<String?> getPlatformVersion() {
    return MarvelflutterPlatform.instance.getPlatformVersion();
  }
  Future<int?> startMarvel(String marvelId, Map<String, dynamic> config) {
    return MarvelflutterPlatform.instance.startMarvel(marvelId,config);
  }

  /// Submits a Crashlytics report of a caught error.
  Future<void> recordError(dynamic exception, StackTrace? stack,
      {dynamic reason,
      Iterable<Object> information = const [],
      bool? printDetails,
      bool fatal = false}) async {
    // Use the debug flag if printDetails is not provided
    printDetails ??= kDebugMode;

    final String _information = information.isEmpty
        ? ''
        : (StringBuffer()..writeAll(information, '\n')).toString();

    if (printDetails) {
      // ignore: avoid_print
      print('----------------FIREBASE CRASHLYTICS----------------');

      // If available, give a reason to the exception.
      if (reason != null) {
        // ignore: avoid_print
        print('The following exception was thrown $reason:');
      }

      // Need to print the exception to explain why the exception was thrown.
      // ignore: avoid_print
      print(exception);

      // Print information provided by the Flutter framework about the exception.
      // ignore: avoid_print
      if (_information.isNotEmpty) print('\n$_information');

      // Not using Trace.format here to stick to the default stack trace format
      // that Flutter developers are used to seeing.
      // ignore: avoid_print
      if (stack != null) print('\n$stack');
      // ignore: avoid_print
      print('----------------------------------------------------');
    }

    // Replace null or empty stack traces with the current stack trace.
    final StackTrace stackTrace = (stack == null || stack.toString().isEmpty)
        ? StackTrace.current
        : stack;

    // Report error.
    final List<Map<String, String>> stackTraceElements =
        getStackTraceElements(stackTrace);
    final String? buildId = getBuildId(stackTrace);

    return MarvelflutterPlatform.instance.recordError(
      exception: exception.toString(),
      reason: reason.toString(),
      information: _information,
      stackTraceElements: stackTraceElements,
      buildId: buildId,
      fatal: fatal,
    );
  }
  /// Submits a Crashlytics report of an error caught by the Flutter framework.
  /// Use [fatal] to indicate whether the error is a fatal or not.
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails,
      {bool fatal = false}) {
    FlutterError.presentError(flutterErrorDetails);

    final information = flutterErrorDetails.informationCollector?.call() ?? [];

    return recordError(
      flutterErrorDetails.exceptionAsString(),
      flutterErrorDetails.stack,
      reason: flutterErrorDetails.context,
      information: information,
      printDetails: false,
      fatal: fatal,
    );
  }

  /// Submits a Crashlytics report of a fatal error caught by the Flutter framework.
  Future<void> recordFlutterFatalError(
      FlutterErrorDetails flutterErrorDetails) {
    return recordFlutterError(flutterErrorDetails, fatal: true);
  }

}
