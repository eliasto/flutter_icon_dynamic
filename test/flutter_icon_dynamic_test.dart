import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_icon_dynamic/flutter_icon_dynamic.dart';
import 'package:flutter_icon_dynamic/flutter_icon_dynamic_platform_interface.dart';
import 'package:flutter_icon_dynamic/flutter_icon_dynamic_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterIconDynamicPlatform
    with MockPlatformInterfaceMixin
    implements FlutterIconDynamicPlatform {
  @override
  Future<bool> get isSupported => Future.value(true);

  @override
  Future<bool> setIcon(String iconName, List<String>? androidIcons) {
    return Future.value(true);
  }
}

void main() {
  final FlutterIconDynamicPlatform initialPlatform =
      FlutterIconDynamicPlatform.instance;

  test('$MethodChannelFlutterIconDynamic is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterIconDynamic>());
  });

  test('getIsSupported', () async {
    FlutterIconDynamic flutterIconDynamicPlugin = FlutterIconDynamic();
    MockFlutterIconDynamicPlatform fakePlatform =
        MockFlutterIconDynamicPlatform();
    FlutterIconDynamicPlatform.instance = fakePlatform;

    expect(await flutterIconDynamicPlugin.isSupported, true);
  });
}
