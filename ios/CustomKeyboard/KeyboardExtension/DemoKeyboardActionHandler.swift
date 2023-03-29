//
//  DemoKeyboardActionHandler.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This demo-specific action handler inherits the standard one
 and adds demo-specific logic to it.
 
 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom keyboard action handler.
 
 If you add `image` actions to the keyboard, this class will
 copy any tapped image to the pasteboard and save it to your
 photo album when it's long presed.
 */
class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    public var input: String = "";
    
    // MARK: - Overrides
    
    override func action(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> KeyboardAction.GestureAction? {
        print("DemoKeyboardActionHandler::action::gesture(\(gesture)) action(\(action))")
        let standard = super.action(for: gesture, on: action)
        switch gesture {
        case .press: return pressAction(for: action) ?? standard
        case .longPress: return longPressAction(for: action) ?? standard
        case .release: return releaseAction(for: action) ?? standard
        default: return standard
        }
    }
    
    
    // MARK: - Custom actions
    
    private var pressedCharacter: String = "";
    
    func pressAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case .space:
            pressedCharacter = " "
            return nil
        case .emoji(let emoji):
            pressedCharacter = emoji.char
            return nil
        case .character(let character):
            pressedCharacter = character
            return nil
        default: return nil
        }
    }
    
    func longPressAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] _ in self?.saveImage(named: imageName) }
        default: return nil
        }
    }
    
    func releaseAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case .dismissKeyboard:
            handleDismissKeyboard()
            return nil
        case .emoji(let emoji):
            handleReleaseAction(with: emoji.char)
            return nil
        case .space:
            handleReleaseAction(with: " ")
            return nil
        case .character(let character):
            handleReleaseAction(with: character)
            return nil
        case .image(_, _, let imageName): return { [weak self] _ in self?.copyImage(named: imageName) }
        default: return nil
        }
    }
    
    
    
    // MARK: - Functions
    func handleReleaseAction(with releasedCharacter: String) {
        if (pressedCharacter == releasedCharacter) {
            print("DemoKeyboardActionHandler::releaseAction::just pressed character \(pressedCharacter)")
            self.input.append(pressedCharacter)
        }
    }
    
    func handleDismissKeyboard() {
        alert("Dissmising keyboard and will sync input repo with \"\(self.input)\"")
        self.syncInputToUserDefaults()
    }
    
    public func syncInputToUserDefaults() {
        if self.input == "" {
            self.alert("Skip sync due to empty input")
            return
        }
        guard let viewController = keyboardController as? CustomKeyboardViewController else {
            self.alert("Cannot communitcate with view controller")
            return
        }
        
        viewController.syncInputToUserDefaults(self.input)
        
        self.input = "";
    }
    
    func alert(_ message: String) {
        print("alert: \(message)")
    }
    
    func copyImage(named imageName: String) {
        guard let image = UIImage(named: imageName) else { return }
        guard keyboardContext.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }
    
    func saveImage(named imageName: String) {
        guard let image = UIImage(named: imageName) else { return }
        guard keyboardContext.hasFullAccess else { return alert("You must enable full access to save images.") }
        image.saveToPhotos(completion: handleImageDidSave)
        alert("Saved to photos!")
    }
}

private extension DemoKeyboardActionHandler {
    
    func handleImageDidSave(withError error: Error?) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
}

private extension UIImage {
    
    func copyToPasteboard(_ pasteboard: UIPasteboard = .general) -> Bool {
        guard let data = pngData() else { return false }
        pasteboard.setData(data, forPasteboardType: "public.png")
        return true
    }
}

private extension UIImage {
    
    func saveToPhotos(completion: @escaping (Error?) -> Void) {
        ImageService.default.saveImageToPhotos(self, completion: completion)
    }
}


/**
 This class is used as a target/selector holder by the image
 extension above.
 */
private class ImageService: NSObject {
    
    public typealias Completion = (Error?) -> Void
    
    public static private(set) var `default` = ImageService()
    
    private var completions = [Completion]()
    
    public func saveImageToPhotos(_ image: UIImage, completion: @escaping (Error?) -> Void) {
        completions.append(completion)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImageToPhotosDidComplete), nil)
    }
    
    @objc func saveImageToPhotosDidComplete(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
        guard completions.count > 0 else { return }
        completions.removeFirst()(error)
    }
}
