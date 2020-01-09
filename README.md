# flutter\_install\_app\_plugin

A Flutter plug-in helps to install iOS and Android apps.

## Usage

It is not uncommon that you may want to ask a user to install another app within your app. What you need to do here is to prepare a set of iOS app ID on App Store, and Android package name.

For example, if you want to lead your customers to install [KKBOX](https://www.kkbox.com/), you need to create an app set like:

```dart
var app = AppSet()
..iosAppId = 300915900
..androidPackageName = 'com.skysoft.kkbox.android';
```

Then call the plug-in.

```dart
FlutterInstallAppPlugin.installApp(app);
```

On iOS, the plug-in calls [SKStoreProductViewController](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller), while it creates an activity to open a  URL with "market://" prefix on Android.

## Additional Parameters for iOS

On iOS, you can use additional parameters including:

- `iosIapId`: Represents the product identifier for the promoted product you want the store to display at the top of the page. See [SKStoreProductParameterProductIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameterproductidentifier).
- `iosAffiliateToken`: Your affiliate identifier. You receive an affiliate identifier when you sign up for Apple's Affiliate Program. See [SKStoreProductParameterAffiliateToken](https://developer.apple.com/documentation/storekit/skstoreproductparameteraffiliatetoken).
- `iosCampaignToken`: Represents an App Analytics campaign. This token allows you to track the effectiveness of your Affiliate Program link and your App Analytics campaign. See [SKStoreProductParameterCampaignToken](https://developer.apple.com/documentation/storekit/skstoreproductparametercampaigntoken).
- `iosAdvertisingPartnerToken`: Represents the advertising partner you wish to use. See [SKStoreProductParameterAdvertisingPartnerToken](https://developer.apple.com/documentation/storekit/skstoreproductparameteradvertisingpartnertoken)
- `iosProviderToken`: Represents the provider token for the developer that created the app. See [SKStoreProductParameterProviderToken](https://developer.apple.com/documentation/storekit/skstoreproductparameterprovidertoken).


That's all. Enjoy!
