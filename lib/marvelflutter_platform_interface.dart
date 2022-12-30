import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'marvelflutter_method_channel.dart';

abstract class MarvelflutterPlatform extends PlatformInterface {
  /// Constructs a MarvelflutterPlatform.
  MarvelflutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static MarvelflutterPlatform _instance = MethodChannelMarvelflutter();

  /// The default instance of [MarvelflutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelMarvelflutter].
  static MarvelflutterPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MarvelflutterPlatform] when
  /// they register themselves.
  static set instance(MarvelflutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<int?> startMarvel(String marvelId, Map<String, dynamic> config) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
    /// Submits a Crashlytics report of a caught error.
  Future<void> recordError({
    required String exception,
    required String information,
    required String reason,
    bool fatal = false,
    String? buildId,
    String? stackTraceElements,
    // List<Map<String, String>>? stackTraceElements,
  }) {
    throw UnimplementedError('recordError() is not implemented');
  }
}
