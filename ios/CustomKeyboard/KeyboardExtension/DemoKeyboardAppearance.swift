//
//  DemoKeyboardAppearance.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This demo-specific appearance inherits the standard one and
 customizes the look of the keyboard.

 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom keyboard appearance.

 Just comment out any of the functions below to override any
 part of the standard appearance.
 */
class DemoKeyboardAppearance: StandardKeyboardAppearance {
    
    // override func buttonImage(for action: KeyboardAction) -> Image? {
    //     if action == .keyboardType(.emojis) { return nil }
    //     return super.buttonImage(for: action)
    // }

     override func buttonStyle(
         for action: KeyboardAction,
         isPressed: Bool
     ) -> KeyboardButtonStyle {
         var style = super.buttonStyle(for: action, isPressed: isPressed)
//         style.cornerRadius = 10
         style.backgroundColor = Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.1)
         style.foregroundColor = .white
         return style
     }
    
    override func buttonImage(for action: KeyboardAction) -> Image? {
        var image = super.buttonImage(for: action)
        if action == .backspace {
            return image?.foregroundColor(.white) as? Image
        }
        return image
    }

     override func buttonText(for action: KeyboardAction) -> String? {
         if action == .backspace { return "⏎" }
         if action == .space { return "" }
         if action == .keyboardType(.emojis) { return "🤯" }
         return super.buttonText(for: action)
     }

     override var actionCalloutStyle: ActionCalloutStyle {
         var style = super.actionCalloutStyle
         style.callout.backgroundColor = .red
         return style
     }

     override var inputCalloutStyle: InputCalloutStyle {
         var style = super.inputCalloutStyle
         style.callout.backgroundColor = .blue
         style.callout.textColor = .yellow
         return style
     }
}
