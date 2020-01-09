import Flutter
import UIKit
import StoreKit

struct AppConfig: Codable {
	var iosAppId: Int
	var iosAffiliateToken: String?
	var iosCampaignToken: String?
	var iosAdvertisingPartnerToken: String?
	var iosProviderToken: String?
	var iosIapId: String?
}

enum SwiftFlutterInstallAppPluginError: String, Error, LocalizedError {
	case invalidMethod = "invalidMethod"
	case invalidJson = "invalidJson"

	var errorDescription: String? {
		switch self {
		case .invalidMethod:
			return "Invalid method"
		case .invalidJson:
			return "Invalid format."
		}
	}

	var flutterError: FlutterError {
		return FlutterError(code: self.rawValue, message: self.errorDescription, details: nil)
	}
}

public class SwiftFlutterInstallAppPlugin: NSObject, FlutterPlugin {
	public static func register(with registrar: FlutterPluginRegistrar) {
		let channel = FlutterMethodChannel(name: "flutter_install_app_plugin", binaryMessenger: registrar.messenger())
		let instance = SwiftFlutterInstallAppPlugin()
		registrar.addMethodCallDelegate(instance, channel: channel)
	}

	public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
		// Handles only the "installApp" method.
		if call.method != "installApp" {
			result(SwiftFlutterInstallAppPluginError.invalidMethod.flutterError)
			return
		}
		guard let string = call.arguments as? String,
			let data = string.data(using: .utf8) else {
				result(SwiftFlutterInstallAppPluginError.invalidJson.flutterError)
				return
		}
		let decoder = JSONDecoder()
		do {
			let config = try decoder.decode(AppConfig.self, from: data)
			install(config: config)
			result(nil)
		} catch {
			let flutterError = FlutterError(code:SwiftFlutterInstallAppPluginError.invalidJson.rawValue, message: error.localizedDescription, details: nil)
			result(flutterError)
		}
	}
}

extension SwiftFlutterInstallAppPlugin: SKStoreProductViewControllerDelegate {
	private func install(config: AppConfig) {
		guard let root = UIApplication.shared.keyWindow?.rootViewController else {
			return
		}

		let storeViewController: SKStoreProductViewController = SKStoreProductViewController()
		// https://affiliate.itunes.apple.com/resources/documentation/getting-started/
		var params: [String: Any] = [
			SKStoreProductParameterITunesItemIdentifier: config.iosAppId,
			SKStoreProductParameterAffiliateToken: config.iosAffiliateToken ?? "",
			SKStoreProductParameterCampaignToken: config.iosCampaignToken ?? ""
		]
		if #available(iOS 11.0, *) {
			if let iosIapId = config.iosIapId  {
				params[SKStoreProductParameterProductIdentifier] = iosIapId
			}
		}
		if #available(iOS 8.3, *) {
			if let iosProviderToken = config.iosProviderToken  {
				params[SKStoreProductParameterProviderToken] = iosProviderToken
			}
		}
		if #available(iOS 9.3, *) {
			if let iosAdvertisingPartnerToken = config.iosAdvertisingPartnerToken {
				params[SKStoreProductParameterAdvertisingPartnerToken] = iosAdvertisingPartnerToken
			}
		}

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
