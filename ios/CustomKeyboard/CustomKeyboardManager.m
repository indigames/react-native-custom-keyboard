#import "CustomKeyboardManager.h"
#import "react_native_custom_keyboard-Swift.h"

#import <React/RCTLinkingManager.h>

@implementation CustomKeyboardManager

+ (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    [CustomKeyboardMessenger shareWithApplication:app openUrl:url options:options];
    return [RCTLinkingManager application:app openURL:url options:options];
}

@end
