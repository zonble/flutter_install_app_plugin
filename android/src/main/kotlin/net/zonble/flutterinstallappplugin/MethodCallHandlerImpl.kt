package net.zonble.flutterinstallappplugin

import android.app.Activity
import android.content.Intent
import android.net.Uri
import com.google.gson.Gson
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MethodCallHandlerImpl : MethodChannel.MethodCallHandler {
    internal var activity: Activity? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "installApp" -> {
                val activity = this.activity
                        ?: return result.error("Activity not displayed", "This plugin requires a active Activity to function.", null)

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