@objc(RNCustomKeyboard)
class RNCustomKeyboard: NSObject {
   @objc func isEnabled(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock){
        resolve(false)
    }
    
    @objc func isActivated(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock){
        resolve(false)
    }
}