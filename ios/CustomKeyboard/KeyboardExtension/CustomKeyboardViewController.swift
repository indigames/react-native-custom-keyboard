import SwiftUI
open class CustomKeyboardViewController: KeyboardInputViewController {
    var hostAppId: String?
    var hostAppUrlScheme: String?
    var customActionHandler: DemoKeyboardActionHandler?
    
    open override func viewDidLoad() {
        if let hostAppId = Bundle.main.object(forInfoDictionaryKey: HOST_APP_IDENTIFIER_INFO_PLIST_KEY) as? String {
            self.hostAppId = hostAppId
        } else {
            print("Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)")
        }
        
        if let hostAppUrlScheme = Bundle.main.object(forInfoDictionaryKey: HOST_URL_SCHEME_INFO_PLIST_KEY) as? String {
            self.hostAppUrlScheme = hostAppUrlScheme
        } else {
            print("Error: \(NO_INFO_PLIST_URL_SCHEME_ERROR)")
        }
        
        keyboardContext.setLocale(.english)
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)
        keyboardAppearance = DemoKeyboardAppearance(keyboardContext: keyboardContext)
        self.customActionHandler = DemoKeyboardActionHandler(inputViewController: self)
        keyboardActionHandler = self.customActionHandler!
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(keyboardContext: keyboardContext, inputSetProvider: inputSetProvider)
        super.viewDidLoad()
    }
    
    open override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        setup(with: DemoKeyboardView(controller: self, actionHandler: self.customActionHandler!))
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        syncInputToUserDefaults(customActionHandler?.input ?? "")
    }
    
    public func syncInputToUserDefaults(_ input: String) {
        if input == "" {
            print(NO_INPUT_ERROR)
            return
        }
        
        guard let hostAppId = self.hostAppId else {
            print(NO_INFO_PLIST_INDENTIFIER_ERROR)
            return
        }
        
        guard let userDefaults = UserDefaults(suiteName: hostAppId) else {
            print(NO_APP_GROUP_ERROR)
            return
        }
        
        var allInput = input
        if let containerInput = userDefaults.object(forKey: USER_DEFAULTS_KEY) as? String {
            allInput.append(containerInput)
        } else {
            print("CustomKeyboardViewController::warning: \(NO_INPUT_DATA_ERROR) (It is safe to skip this warning)")
        }
        
        // print("CustomKeyboardViewController::sync input container \(userDefaults) with key \(USER_DEFAULTS_KEY) and value \(allInput)")
        userDefaults.set(allInput, forKey: USER_DEFAULTS_KEY)
        userDefaults.synchronize()
    }
}
