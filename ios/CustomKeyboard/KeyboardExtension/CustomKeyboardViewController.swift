import SwiftUI
open class CustomKeyboardViewController: KeyboardInputViewController {
    var appGroupId: String?
    var hostAppUrlScheme: String?
    var customActionHandler: DemoKeyboardActionHandler?
    var userDefault: UserDefaults?
    
    open override func viewDidLoad() {
        if let appGroupId = Bundle.main.object(forInfoDictionaryKey: HOST_APP_IDENTIFIER_INFO_PLIST_KEY) as? String {
            self.appGroupId = appGroupId
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
    
    private var demoKeyboardView: DemoKeyboardView?
    open override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        demoKeyboardView = DemoKeyboardView(controller: self, actionHandler: self.customActionHandler!)
        setup(with: self.demoKeyboardView)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let userDefaults = getUserDefaults() else {
            print("Cannot get user defaults.")
            return
        }
        
        if let backgroundPath = userDefaults.object(forKey: USER_DEFAULTS_BACKGROUND_PATH) as? String {
            self.demoKeyboardView?.backgroundPath = backgroundPath
//            (keyboardAppearance as! DemoKeyboardAppearance).backgroundImage(for: backgroundPath)
        } else {
            userDefaults.set("", forKey: USER_DEFAULTS_BACKGROUND_PATH)
            userDefaults.synchronize()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        syncInputToUserDefaults(customActionHandler?.input ?? "")
    }
    
    private func getUserDefaults() -> UserDefaults? {
        guard let appGroupId = self.appGroupId else {
            print(NO_INFO_PLIST_INDENTIFIER_ERROR)
            return nil
        }
        
        if self.userDefault == nil {
            guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
                print(NO_APP_GROUP_ERROR)
                return nil
            }
            self.userDefault = userDefaults
        }
        
        return self.userDefault
    }
    
    public func syncInputToUserDefaults(_ input: String) {
        if input == "" {
            print(NO_INPUT_ERROR)
            return
        }
        
        guard let userDefaults = getUserDefaults() else {
            print("Cannot get user defaults.")
            return
        }
       
        var allInput = input
        if let containerInput = userDefaults.object(forKey: USER_DEFAULTS_KEY) as? String {
            allInput.append(containerInput)
        } else {
            print("CustomKeyboardViewController::warning: \(NO_INPUT_DATA_ERROR) (It is safe to skip this warning)")
        }
        
        userDefaults.set(allInput, forKey: USER_DEFAULTS_KEY)
        userDefaults.synchronize()
    }
}
