import Flutter
import UIKit

public class FlutterIconDynamicPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_icon_dynamic", binaryMessenger: registrar.messenger())
    let instance = FlutterIconDynamicPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isSupported":
      result(UIApplication.shared.supportsAlternateIcons)
    case "setIcon":
      if let arguments = call.arguments as? [String: Any],
         let iconName = arguments["iconName"] as? String {
        setAppIcon(iconName: iconName, result: result)
      } else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing or invalid arguments", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func setAppIcon(iconName: String?, result: @escaping FlutterResult) {
    guard UIApplication.shared.supportsAlternateIcons else {
      result(FlutterError(code: "UNSUPPORTED", message: "Alternate icons are not supported on this device", details: nil))
      return
    }

    UIApplication.shared.setAlternateIconName(iconName) { error in
      if let error = error {
        result(FlutterError(code: "SET_ICON_FAILED", message: "Failed to set icon", details: error.localizedDescription))
      } else {
        result(true)
      }
    }
  }
}
