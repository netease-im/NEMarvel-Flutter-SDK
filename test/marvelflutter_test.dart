import 'package:flutter_test/flutter_test.dart';
import 'package:marvelflutter/marvelflutter.dart';
import 'package:marvelflutter/marvelflutter_platform_interface.dart';
import 'package:marvelflutter/marvelflutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMarvelflutterPlatform 
    with MockPlatformInterfaceMixin
    implements MarvelflutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MarvelflutterPlatform initialPlatform = MarvelflutterPlatform.instance;

  test('$MethodChannelMarvelflutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMarvelflutter>());
  });

  test('getPlatformVersion', () async {
    Marvelflutter marvelflutterPlugin = Marvelflutter();
    MockMarvelflutterPlatform fakePlatform = MockMarvelflutterPlatform();
    MarvelflutterPlatform.instance = fakePlatform;
  
    expect(await marvelflutterPlugin.getPlatformVersion(), '42');
  });
}
