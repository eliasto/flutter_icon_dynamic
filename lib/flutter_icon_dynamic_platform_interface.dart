import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_icon_dynamic_method_channel.dart';

abstract class FlutterIconDynamicPlatform extends PlatformInterface {
  /// Constructs a FlutterIconDynamicPlatform.
  FlutterIconDynamicPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterIconDynamicPlatform _instance =
      MethodChannelFlutterIconDynamic();

  /// The default instance of [FlutterIconDynamicPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterIconDynamic].
  static FlutterIconDynamicPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterIconDynamicPlatform] when
  /// they register themselves.
  static set instance(FlutterIconDynamicPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> setIcon(String iconName, List<String>? androidIcons) {
    throw UnimplementedError('setIcon() has not been implemented.');
  }

  Future<bool> get isSupported {
    throw UnimplementedError('isSupported() has not been implemented.');
  }
}
