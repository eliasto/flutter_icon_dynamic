package sncf.connect.tech.flutter_icon_dynamic

import android.content.ComponentName
import android.content.Context
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterIconDynamicPlugin */
class FlutterIconDynamicPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_icon_dynamic")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "isSupported") {
            result.success(true)
        } else if (call.method == "setIcon") {
            val iconName = call.argument<String>("iconName")
            val androidIcons = call.argument<List<String>>("androidIcons")
            if (iconName != null && androidIcons != null) {
                changeIcon(iconName, androidIcons, result)
            } else {
                result.error("INVALID_ARGUMENT", "Icon name and android icons must not be null", null)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun changeIcon(iconName: String, androidIcons: List<String>, result: Result) {
        val packageManager = context.applicationContext.packageManager

        try {
            for (icon in androidIcons) {
                packageManager.setComponentEnabledSetting(
                    ComponentName(context.packageName, icon),
                    if (icon == iconName) PackageManager.COMPONENT_ENABLED_STATE_ENABLED else PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                    PackageManager.DONT_KILL_APP
                )
            }

            result.success(true)
        } catch (e: Exception) {
            result.error("ERROR", "Failed to change app icon: ${e.message}", null)
        }
    }
}
