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

        //print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ loading background \(self.backgroundPath)")
        let backgroundUrl = URL(fileURLWithPath: self.backgroundPath)
        //print("startAccessingSecurityScopedResource: \(backgroundUrl.startAccessingSecurityScopedResource())")
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
