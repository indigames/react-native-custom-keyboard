//
//  MockKeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockKeyboardFeedbackHandler: Mock, KeyboardFeedbackHandler {
    
    lazy var triggerFeedbackRef = MockReference(triggerFeedback)    
    lazy var triggerAudioFeedbackRef = MockReference(triggerAudioFeedback)
    lazy var triggerHapticFeedbackRef = MockReference(triggerHapticFeedback)
    
    func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        call(triggerFeedbackRef, args: (gesture, action))
    }
    
    func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        call(triggerAudioFeedbackRef, args: (gesture, action))
    }
    
    func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        call(triggerHapticFeedbackRef, args: (gesture, action))
    }
}
