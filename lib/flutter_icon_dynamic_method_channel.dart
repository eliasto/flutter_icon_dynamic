import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_icon_dynamic_platform_interface.dart';

/// An implementation of [FlutterIconDynamicPlatform] that uses method channels.
class MethodChannelFlutterIconDynamic extends FlutterIconDynamicPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_icon_dynamic');

  @override
  Future<bool> setIcon(String iconName, List<String>? androidIcons) async {
    final icon = await methodChannel.invokeMethod<bool>('setIcon', {
      'iconName': iconName,
      'androidIcons': androidIcons,
    });
    return icon ?? false;
  }

  @override
  Future<bool> get isSupported async {
    final supported = await methodChannel.invokeMethod<bool>('isSupported');
    return supported ?? false;
  }
}
