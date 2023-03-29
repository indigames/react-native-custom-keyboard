
@objc(RNEventEmitter)
class RNEventEmitter: RCTEventEmitter {
    
    private(set) static var _shared: RNEventEmitter?
    @objc public static var shared: RNEventEmitter
    {
        get {
            return RNEventEmitter._shared!
        }
    }
    
    static var initialShare: (UIApplication, URL, [UIApplication.OpenURLOptionsKey : Any])?
    
    var hasListeners = false
    
    var _targetUrlScheme: String?
    var targetUrlScheme: String
    {
        get {
            return _targetUrlScheme!
        }
    }
    
    public override init() {
        super.init()
        RNEventEmitter._shared = self
        
        // if already has app, url, options from previous linking
        if let (app, url, options) = RNEventEmitter.initialShare {
            // then share data
            shareInputUsingDeepLinking(application: app, openUrl: url, options: options)
        }
    }
    
    override static public func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    open override func supportedEvents() -> [String]! {
        return [SYNC_INPUT_EVENT]
    }
    
    open override func startObserving() {
        hasListeners = true
    }
    
    open override func stopObserving() {
        hasListeners = false
    }
    
    public static func syncInput(
        application app: UIApplication,
        openUrl url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any]
    ) {
        // try to sync input even RNEventEmitter instance not instantiated yet through react native
        guard (RNEventEmitter._shared != nil) else {
            initialShare = (app, url, options)
            return
        }
        
        RNEventEmitter.shared.shareInputUsingDeepLinking(application: app, openUrl: url, options: options)
    }
    
    func shareInputUsingDeepLinking(
        application app: UIApplication,
        openUrl url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any]
    ) {
        if _targetUrlScheme == nil {
            guard let bundleUrlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [NSDictionary] else {
                print("RNEventEmitter::Error: \(NO_URL_TYPES_ERROR_MESSAGE)")
                return
            }
            guard let bundleUrlSchemes = bundleUrlTypes.first?.value(forKey: "CFBundleURLSchemes") as? [String] else {
                print("RNEventEmitter::Error: \(NO_URL_SCHEMES_ERROR_MESSAGE)")
                return
            }
            guard let expectedUrlScheme = bundleUrlSchemes.first else {
                print("RNEventEmitter::Error \(NO_URL_SCHEMES_ERROR_MESSAGE)")
                return
            }
            
            _targetUrlScheme = expectedUrlScheme
        }
        
        // check if we are in the same app group through deep linking
        guard let scheme = url.scheme, scheme == targetUrlScheme else { return }
        
        if let input = getInputTextFromUserDefaults() {
            raiseSyncInputEvent(with: input)
        }
    }
    
    func getInputTextFromUserDefaults() -> String? {
        guard let containerId = Bundle.main.object(forInfoDictionaryKey: HOST_APP_IDENTIFIER_INFO_PLIST_KEY) as? String else {
            print("RNEventEmitter::Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)")
            return nil
        }
        
        guard let userDefaults = UserDefaults(suiteName: containerId) else {
            print("RNEventEmitter::Error: \(NO_APP_GROUP_ERROR)")
            return nil
        }
        
        guard let input = userDefaults.object(forKey: USER_DEFAULTS_KEY) as? String else {
            print("RNEventEmitter::Error: \(NO_INPUT_DATA_ERROR)")
            userDefaults.set("", forKey: USER_DEFAULTS_KEY)
            userDefaults.synchronize()
            return nil
        }
        
        if input == "" {
            print("RNEventEmitter::Error: \(NO_INPUT_DATA_ERROR)")
            return nil
        }
        
        userDefaults.set("", forKey: USER_DEFAULTS_KEY)
        userDefaults.synchronize()
        return input
    }
    
    // MARKS: JS
    @objc func syncNativeInput() {
        print("RNEventEmitter::syncNativeInput")
        if let input = getInputTextFromUserDefaults() {
            print("RNEventEmitter::syncNativeInput::with: \(input)")
            raiseSyncInputEvent(with: input)
        }
    }
    
    func raiseSyncInputEvent(with input: String) {
        guard hasListeners else { return }
        
        sendEvent(withName: SYNC_INPUT_EVENT, body: input)
    }
}
