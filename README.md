# flutter_install_app_plugin

A Flutter plug-in helps to install iOS and Android apps.

## Usage

It is not uncommon that you may want to ask a user to install another app within your app. What you need to do here is to prepare a set of iOS app ID on App Store, and Android package name.

For example, if you want to lead your customers to install [KKBOX](https://www.kkbox.com/), you need to create an app set like:

```dart
    var app = AppSet();
    app.iosAppId = 300915900;
    app.androidPackageName = 'com.skysoft.kkbox.android';
```

Then call the plug-in.

```dart
    FlutterInstallAppPlugin.installApp(app);
```

On iOS, the plug-in calls [SKStoreProductViewController](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller), while it creates an activity to open a "market://" URL on Android.

That's all. Enjoy!
