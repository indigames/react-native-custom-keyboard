#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNCustomKeyboard, NSObject)

RCT_EXTERN_METHOD(setBackground:(NSString *)backgroundPath)

RCT_EXTERN_METHOD(getPathForAppGroup:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getEnableState:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getActiveState:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getFullAccessState:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
