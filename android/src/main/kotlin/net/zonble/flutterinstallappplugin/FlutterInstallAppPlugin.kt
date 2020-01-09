package net.zonble.flutterinstallappplugin

import android.app.Activity
import android.content.Intent
import android.net.Uri
import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterInstallAppPlugin(private val activity: Activity) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val activity = registrar.activity()
            if (activity != null) {
                val channel = MethodChannel(registrar.messenger(), "flutter_install_app_plugin")
                channel.setMethodCallHandler(FlutterInstallAppPlugin(activity))
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "installApp" -> {
                val args = call.arguments as? String
                args?.let {
                    val appConfig = Gson().fromJson(args, AppConfig::class.java)
                    val appPackageName = appConfig.androidPackageName
                    try {
                        activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$appPackageName")))
                    } catch (anfe: android.content.ActivityNotFoundException) {
                        activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")))
                    }
                } ?: result.error("Invalid format", null, null)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
}


data class AppConfig(
        @SerializedName("androidPackageName") var androidPackageName: String
)