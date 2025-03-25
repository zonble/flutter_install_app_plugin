package net.zonble.flutterinstallappplugin

import android.app.Activity
import com.google.gson.annotations.SerializedName
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class FlutterInstallAppPlugin : FlutterPlugin, ActivityAware {
    private var channel: MethodChannel? = null
    private var methodCallHandler: MethodCallHandlerImpl? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) =
        onActivityChanged(binding.activity)

    override fun onDetachedFromActivityForConfigChanges() = onActivityChanged(null)

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) =
        onActivityChanged(binding.activity)

    override fun onDetachedFromActivity() = onActivityChanged(null)

    private fun onAttachedToEngine(messenger: BinaryMessenger) {
        channel = MethodChannel(messenger, "flutter_install_app_plugin")
        methodCallHandler = MethodCallHandlerImpl()
        channel?.setMethodCallHandler(methodCallHandler)
    }

    private fun onActivityChanged(activity: Activity?) {
        methodCallHandler?.activity = activity
    }
}


data class AppConfig(
    @SerializedName("androidPackageName") var androidPackageName: String,
)