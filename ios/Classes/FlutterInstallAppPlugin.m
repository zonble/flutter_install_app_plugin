#import "FlutterInstallAppPlugin.h"
#import <flutter_install_app_plugin/flutter_install_app_plugin-Swift.h>

@implementation FlutterInstallAppPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterInstallAppPlugin registerWithRegistrar:registrar];
}
@end
