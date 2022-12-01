
import 'marvelflutter_platform_interface.dart';

class Marvelflutter {
  Future<String?> getPlatformVersion() {
    return MarvelflutterPlatform.instance.getPlatformVersion();
  }
}
