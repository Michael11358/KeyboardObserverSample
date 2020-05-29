//
//  ViewController.swift
//  KeyboardObserverSample
//
//  Created by Voline, Michael on 2020-03-29.
//  Copyright © 2020 KeyboardObserver. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: Properties
    private let keyboardObserver = KeyboardObserver()

    // MARK: IBOutlets
    @IBOutlet private var textField: UITextField!

    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardObserver.observeKeyboardWillHide {
            print("hide")
        }
        
        keyboardObserver.observeKeyboardWillShow { height in
            print(height)
        }
    }

    // MARK: IBActions
    @IBAction private func didTapView(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
