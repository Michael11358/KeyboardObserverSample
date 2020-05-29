//
//  KeyboardObserver.swift
//  KeyboardObserverSample
//
//  Created by Voline, Michael on 2020-03-29.
//  Copyright © 2020 KeyboardObserver. All rights reserved.
//

import UIKit

/// Use this class to subscribe to system keyboard notifications.
final class KeyboardObserver {

    // MARK: Properties
    private let notificationCenter: NotificationCenter
    private var observers = [NSObjectProtocol]()

    // MARK: Initialization
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    deinit {
        observers.forEach { notificationCenter.removeObserver($0) }
    }

    // MARK: Public
    func observeKeyboardWillShow(handler: @escaping (_ height: CGFloat) -> Void) {
        addObserver(name: UIResponder.keyboardWillShowNotification) { notification in
            let key = UIResponder.keyboardFrameBeginUserInfoKey
            let info = notification.userInfo?[key] as? NSValue
            let frame = info?.cgRectValue
            if let height = frame?.height {
                handler(height)
            }
        }
    }

    func observeKeyboardWillHide(handler: @escaping () -> Void) {
        addObserver(name: UIResponder.keyboardWillHideNotification) { _ in
            handler()
        }
    }
}

// MARK: - Auxiliary
private extension KeyboardObserver {
    /// Convenient method to add notification.
    func addObserver(name: NSNotification.Name, handler: @escaping (Notification) -> Void) {
        let observer = notificationCenter.addObserver(forName: name,
                                                      object: nil,
                                                      queue: .main,
                                                      using: handler)
        observers.append(observer)
    }
}
