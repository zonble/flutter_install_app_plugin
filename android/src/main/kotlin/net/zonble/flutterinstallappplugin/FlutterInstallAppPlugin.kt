package net.zonble.flutterinstallappplugin

import android.app.Activity
import com.google.gson.annotations.SerializedName
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterInstallAppPlugin : FlutterPlugin, ActivityAware {
    private var channel: MethodChannel? = null
    private var methodCallHandler: MethodCallHandlerImpl? = null

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = FlutterInstallAppPlugin()

            plugin.onAttachedToEngine(registrar.messenger())

            val activity = registrar.activity()
            if (activity != null) {
                plugin.onActivityChanged(activity)
            }
        }
    }

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

    fun onAttachedToEngine(messenger: BinaryMessenger) {
        channel = MethodChannel(messenger, "flutter_install_app_plugin")
        methodCallHandler = MethodCallHandlerImpl()
        channel?.setMethodCallHandler(methodCallHandler)
    }

    fun onActivityChanged(activity: Activity?) {
        methodCallHandler?.activity = activity
    }
}


data class AppConfig(
        @SerializedName("androidPackageName") var androidPackageName: String
)