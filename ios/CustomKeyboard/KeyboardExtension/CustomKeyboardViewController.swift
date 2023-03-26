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
    
    public func syncInputToUserDefaults(_ input: String) {
        guard let hostAppId = self.hostAppId else {
            print(NO_INFO_PLIST_INDENTIFIER_ERROR)
            return
        }
//        guard let userDefaults = UserDefaults(suiteName: "W2MHU9C35Z.group.\(hostAppId)") else {
//        UserDefaults.standard.dictionaryRepresentation()
//        guard let userDefaults = UserDefaults(suiteName: "group.\(hostAppId)") else {
        guard let userDefaults = UserDefaults(suiteName: "group.net.test.group") else {
            print(NO_APP_GROUP_ERROR)
            return
        }
        
        print(FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.net.test.group"))
        print(userDefaults)
        print("set group.\(hostAppId) userDefaults[\(USER_DEFAULTS_KEY)] with: \"\(input)\"")
        userDefaults.set(input, forKey: USER_DEFAULTS_KEY)
        userDefaults.synchronize()
    }
}
