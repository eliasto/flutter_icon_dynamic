import 'flutter_icon_dynamic_platform_interface.dart';

class FlutterIconDynamic {
  Future<bool> setIcon(String iconName, List<String>? androidIcons) {
    return FlutterIconDynamicPlatform.instance.setIcon(iconName, androidIcons);
  }

  Future<bool> get isSupported {
    return FlutterIconDynamicPlatform.instance.isSupported;
  }
}
