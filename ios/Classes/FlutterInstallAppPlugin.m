
#import "FlutterInstallAppPlugin.h"

#if __has_include(<flutter_install_app_plugin/flutter_install_app_plugin-Swift.h>)
#import <flutter_install_app_plugin/flutter_install_app_plugin-Swift.h>
#else
#import "flutter_install_app_plugin-Swift.h"
#endif

@implementation FlutterInstallAppPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterInstallAppPlugin registerWithRegistrar:registrar];
}
@end
