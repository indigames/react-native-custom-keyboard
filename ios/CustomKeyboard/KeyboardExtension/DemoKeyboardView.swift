import SwiftUI

/**
 This view adds a `SystemKeyboard` and two text input fields
 to a `VStack`.
 
 The text fields use a custom `focused` modifier that can be
 used to also automatically show a "done" button when a text
 field receives input. As you can see, the text input fields
 use separate text and focus bindings.
 */
struct DemoKeyboardView: View {
    unowned var controller: KeyboardInputViewController
    unowned var customActionHandler: DemoKeyboardActionHandler
    
    public var backgroundPath: String = ""
    
    init(controller: KeyboardInputViewController, actionHandler: DemoKeyboardActionHandler) {
        self.controller = controller
        self.customActionHandler = actionHandler
    }
    
    var body: some View {
        VStack() {
            Button("SYNC", action: {
                NSLog("Syncing with container app")
                
                self.customActionHandler.syncInputToUserDefaults()
                
                guard let hostAppId = Bundle.main.object(forInfoDictionaryKey: HOST_APP_IDENTIFIER_INFO_PLIST_KEY) as? String else {
                    //            self.hostAppId = hostAppId
                    print("Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)")
                    return
                }
                
                guard let hostAppUrlScheme = Bundle.main.object(forInfoDictionaryKey: HOST_URL_SCHEME_INFO_PLIST_KEY) as? String else {
                    //            self.hostAppUrlScheme = hostAppUrlScheme
                    print("Error: \(NO_INFO_PLIST_URL_SCHEME_ERROR)")
                    return
                }
                
                let url = URL(string: "\(hostAppUrlScheme)://\(hostAppId)")
                print("open URL \(hostAppUrlScheme)")
                let selectorOpenURL = sel_registerName("openURL:")
                var responder: UIResponder? = self.controller
                
                while responder != nil {
                    if responder?.responds(to: selectorOpenURL) == true {
                        responder?.perform(selectorOpenURL, with: url)
                    }
                    responder = responder!.next
                }
                
                controller.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                
            })
            SystemKeyboard(
                controller: controller,
                autocompleteToolbar: .none
            )
            .background(loadBackground)
        }.buttonStyle(.automatic)
    }
    
    private var loadBackground: some View {
        return ZStack {
            loadImage()?.resizable()
            Color.black.opacity(0.3)
        }
    }
    
    private func loadImage() -> Image? {
        if (self.backgroundPath == "") {
            return nil
        }
        
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ loading background \(self.backgroundPath)")
        let backgroundUrl = URL(fileURLWithPath: self.backgroundPath)
        print("startAccessingSecurityScopedResource: \(backgroundUrl.startAccessingSecurityScopedResource())")
        do {
            let imageData = try Data(contentsOf: backgroundUrl)
            backgroundUrl.stopAccessingSecurityScopedResource()
            return Image(uiImage: UIImage(data: imageData)!)
        } catch {
            print("CANNOT LOADING IMAGE: \(error)")
        }
        return nil
    }
}
