@objc open class CustomKeyboardMessenger : NSObject {
    @objc public static func share(
        application app: UIApplication,
        openUrl url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any]
    ) {
        RNEventEmitter.syncInput(application: app, openUrl: url, options: options)
    }
}
