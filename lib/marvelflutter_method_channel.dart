import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'marvelflutter_platform_interface.dart';

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
}
