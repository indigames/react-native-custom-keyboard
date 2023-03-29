@objc(RNCustomKeyboard)
class RNCustomKeyboard: NSObject {
    @objc func getEnableState(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock){
        let keyboardBundleId = "\(Bundle.main.bundleIdentifier!).*"
        print("keyboardBundleId \(keyboardBundleId)")
        resolve(KeyboardEnabledState(bundleId: keyboardBundleId).isKeyboardEnabled)
    }
    
    @objc func getActiveState(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock){
        let keyboardBundleId = "\(Bundle.main.bundleIdentifier!).*"
        print("keyboardBundleId \(keyboardBundleId)")
        resolve(KeyboardEnabledState(bundleId: keyboardBundleId).isKeyboardActive)
    }
    
    @objc func getFullAccessState(_ resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        let keyboardBundleId = "\(Bundle.main.bundleIdentifier!).*"
        print("keyboardBundleId \(keyboardBundleId)")
        resolve(KeyboardEnabledState(bundleId: keyboardBundleId).isFullAccessEnabled)
    }
}
