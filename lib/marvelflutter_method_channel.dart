import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'marvelflutter_platform_interface.dart';

import 'package:flutter/services.dart';


/// An implementation of [MarvelflutterPlatform] that uses method channels.
class MethodChannelMarvelflutter extends MarvelflutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('marvelflutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> startMarvel(String marvelId, Map<String, dynamic> config) async {
    config['marvelId'] =  marvelId;
    final ret = await methodChannel.invokeMethod<int>('startMarvel',config);
    return ret;
  }

  @override
  Future<void> recordError({
    required String exception,
    required String information,
    required String reason,
    bool fatal = false,
    String? buildId,
    String? stackTraceElements,
    // List<Map<String, String>>? stackTraceElements,
  }) async {
    try {
      await methodChannel.invokeMethod<void>('reportUserException', <String, dynamic>{
        'exception': exception,
        'information': information,
        'reason': reason,
        'fatal': fatal,
        'buildId': buildId ?? '',
        'stackTrace': stackTraceElements ?? [],
      });
    } on PlatformException catch (e, s) {
      // convertPlatformException(e, s);
      var stackTrace = s;
      if (stackTrace == StackTrace.empty) {
        stackTrace = StackTrace.current;
      }

      if (e is! PlatformException) {
        Error.throwWithStackTrace(e, stackTrace);
      }

      Error.throwWithStackTrace(
        Exception('MarvelFlutter#recordError'),
        stackTrace,
      );
    }
  }
}
