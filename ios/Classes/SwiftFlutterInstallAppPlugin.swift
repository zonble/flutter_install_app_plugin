import Flutter
import UIKit
import StoreKit
    
public class SwiftFlutterInstallAppPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_install_app_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterInstallAppPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
	if call.method != "installApp" {
		result(nil)
		return
	}
	guard let arguments = call.arguments as? [Any],
			let appID = arguments[0] as? Int else {
			result(nil)
			return
	}
	install(appID: appID)
	result(nil)
  }
}

extension SwiftFlutterInstallAppPlugin: SKStoreProductViewControllerDelegate {
	private func install(appID: Int) {
		guard let root = UIApplication.shared.keyWindow?.rootViewController else {
			return
		}

		let storeViewController: SKStoreProductViewController = SKStoreProductViewController()
		// https://affiliate.itunes.apple.com/resources/documentation/getting-started/
		let params = [
			SKStoreProductParameterITunesItemIdentifier: appID,
			SKStoreProductParameterAffiliateToken: "",
			SKStoreProductParameterCampaignToken: ""
			] as [String: Any]
		storeViewController.loadProduct(withParameters: params, completionBlock: nil)
		storeViewController.delegate = self
		if root.presentedViewController != nil {
			root.dismiss(animated: true) {
				root.present(storeViewController, animated: true, completion: nil)
			}
		} else {
			root.present(storeViewController, animated: true, completion: nil)
		}
	}


	public func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
		viewController.dismiss(animated: true, completion: nil)
	}

}
