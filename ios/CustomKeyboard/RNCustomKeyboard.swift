import SwiftUI

@objc(RNCustomKeyboard)
class RNCustomKeyboard: NSObject {
    @objc func setBackground(_ backgroundPath: String) {
        guard let appGroupId = Bundle.main.object(forInfoDictionaryKey: HOST_APP_IDENTIFIER_INFO_PLIST_KEY) as? String else {
            print("RNCustomKeyboard::Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)")
            return
        }
        
        guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
            print("RNCustomKeyboard::Error: \(NO_APP_GROUP_ERROR)")
            return
        }
        
        userDefaults.set(backgroundPath, forKey: USER_DEFAULTS_BACKGROUND_PATH)
        userDefaults.synchronize()
    }
    
    @objc func getPathForAppGroup(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock) {
        guard let appGroupId = Bundle.main.object(forInfoDictionaryKey: HOST_APP_IDENTIFIER_INFO_PLIST_KEY) as? String else {
            reject(HOST_APP_IDENTIFIER_INFO_PLIST_KEY, "RNCustomKeyboard::Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)", nil)
            return
        }
        
        let fileManager = FileManager.default
        let baseUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupId)
        if baseUrl != nil {
            print("baseUrl \(baseUrl!.path)")
            resolve(baseUrl?.path)
        }
    }
    
    @objc func getEnableState(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock) {
        let keyboardBundleId = "\(Bundle.main.bundleIdentifier!).*"
        print("keyboardBundleId \(keyboardBundleId)")
        resolve(KeyboardEnabledState(bundleId: keyboardBundleId).isKeyboardEnabled)
    }
    
    @objc func getActiveState(_ resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock) {
        let keyboardBundleId = "\(Bundle.main.bundleIdentifier!).*"
        print("keyboardBundleId \(keyboardBundleId)")
        resolve(KeyboardEnabledState(bundleId: keyboardBundleId).isKeyboardActive)
    }
    
    @objc func getFullAccessState(_ resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        let keyboardBundleId = "\(Bundle.main.bundleIdentifier!).*"
        print("keyboardBundleId \(keyboardBundleId)")
        resolve(KeyboardEnabledState(bundleId: keyboardBundleId).isFullAccessEnabled)
    }
    
    @objc func openKeyboardSettings() {
        // General&path=Keyboard/KEYBOARDS
        guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingUrl) {
            UIApplication.shared.open(settingUrl)
        }
    }
}
