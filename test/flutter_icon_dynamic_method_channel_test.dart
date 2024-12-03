import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_icon_dynamic/flutter_icon_dynamic_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterIconDynamic platform = MethodChannelFlutterIconDynamic();
  const MethodChannel channel = MethodChannel('flutter_icon_dynamic');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return true;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getIsSupported', () async {
    expect(await platform.isSupported, true);
  });

  test('setIcon', () async {
    expect(await platform.setIcon('icon', ['icon']), true);
  });
}
