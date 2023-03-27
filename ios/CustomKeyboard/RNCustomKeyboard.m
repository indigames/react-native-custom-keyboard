#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNCustomKeyboard, NSObject)

RCT_EXTERN_METHOD(isEnabled:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(isActivated:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
