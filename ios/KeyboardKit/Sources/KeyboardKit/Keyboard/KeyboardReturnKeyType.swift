//
//  KeyboardReturnKeyType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines various keyboard return button types that
 can be used as ``KeyboardAction/primary(_:)`` actions.

 Return buttons should insert a new line, which will then be
 handled differently depending on the keyboard context. Some
 places will insert the new line, while other places use the
 new line to perform a primary action.

 This is a multi-platform version of `UIReturnKeyType` which
 has a `keyboardReturnKeyType` extension for mapping.
 */
public enum KeyboardReturnKeyType: CaseIterable, Codable, Equatable, Identifiable {

    /// A return key that uses a return text and not an ⏎ icon.
    case `return`

    /// A done key used in e.g. Calendar, when adding a location.
    case done

    /// A go key used in e.g. Mobile Safari, when entering a url.
    case go

    /// A join key used in e.g. System Settings, when joining a wifi network with password.
    case join

    /// A return key that by default uses a ⏎ icon instead of return text.
    case newLine

    /// A next key used in e.g. System Settings, when joining an enterprise wifi network with username and password.
    case next

    /// An ok key, which isn't actually used in native.
    case ok

    /// A search key used in e.g. Mobile Safari, when typing in the google.com search field.
    case search

    /// A send key used in e.g. some messaging apps (WeChat, QQ etc.) when typing in a chat text field.
    case send

    /// A custom key with a custom title.
    case custom(title: String)

    /**
     All unique primary keyboard action types, excluding
     ``KeyboardAction/custom(named:)``.
     */
    public static var allCases: [KeyboardReturnKeyType] {
        [.return, .done, .go, .join, .newLine, .next, .ok, .search, .send]
    }
}

public extension KeyboardReturnKeyType {

    /**
     The type's unique identifier.
     */
    var id: String {
        switch self {
        case .return: return "return"
        case .done: return "done"
        case .go: return "go"
        case .join: return "join"
        case .newLine: return "newLine"
        case .next: return "next"
        case .ok: return "ok"
        case .search: return "search"
        case .send: return "send"
        case .custom(let title): return title
        }
    }

    /**
     Whether or not the action is a system action.

     A system action is by default rendered as a dark button.
     */
    var isSystemAction: Bool {
        switch self {
        case .return: return true
        case .newLine: return true
        default: return false
        }
    }

    /**
     The standard button to image for a certain locale.
     */
    func standardButtonImage(for locale: Locale) -> Image? {
        switch self {
        case .newLine: return .keyboardNewline(for: locale)
        default: return nil
        }
    }

    /**
     The standard button to text for a certain locale.
     */
    func standardButtonText(for locale: Locale) -> String? {
        switch self {
        case .custom(let title): return title
        case .done: return KKL10n.done.text(for: locale)
        case .go: return KKL10n.go.text(for: locale)
        case .join: return KKL10n.join.text(for: locale)
        case .newLine: return nil
        case .next: return KKL10n.next.text(for: locale)
        case .return: return KKL10n.return.text(for: locale)
        case .ok: return KKL10n.ok.text(for: locale)
        case .search: return KKL10n.search.text(for: locale)
        case .send: return KKL10n.send.text(for: locale)
        }
    }
}

#if os(iOS) || os(tvOS)
import UIKit

extension UIReturnKeyType {}

public extension UIReturnKeyType {

    /**
     The corresponding ``KeyboardReturnKeyType``.

     Return types that have no matching primary type will be
     mapped to ``KeyboardReturnKeyType/custom(title:)``.
     */
    var keyboardReturnKeyType: KeyboardReturnKeyType {
        switch self {
        case .default: return .return
        case .done: return .done
        case .go: return .go
        case .google: return .custom(title: "Google")
        case .join: return .join
        case .next: return .next
        case .route: return .custom(title: "route")
        case .search: return .search
        case .send: return .send
        case .yahoo: return .custom(title: "Yahoo")
        case .emergencyCall: return .custom(title: "emergencyCall")
        case .continue: return .custom(title: "continue")
        @unknown default: return .custom(title: "unknown")
        }
    }
}
#endif
