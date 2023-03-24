@objc(CustomKeyboard)
class CustomKeyboard: NSObject {
    @objc func isEnabled(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock){
        resolve(false)
    }

    @objc func isActivated(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock){
        resolve(false)
    }
    
    func log(for text: String) {
        guard text.count > 0 else { return }
        NSLog("\(text)")
    }
    
    func Foo(_ format: String, _ args: CVarArg...) {
        NSLog(format, args)
    }
}
