//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var operations = Validator()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    /// View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:
            #selector(actionView(notification:)), name: .nameView, object: nil)

        NotificationCenter.default.addObserver(self, selector:
            #selector(actionAlert(notification:)), name: .nameAlert, object: nil)
    }
}

// MARK: - UIButton actions
extension ViewController {
    /// When any number button is tapped
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        sender.animated()
        operations.addNumbers(numberText: numberText)
    }

    /// When the dot button is tapped
    @IBAction func tappedDotButton(_ sender: UIButton) {
        guard let dotText = sender.title(for: .normal) else { return }

        sender.animated()
        operations.addDot(dotText: dotText)
    }

    /// When the correction button is tapped
    @IBAction func tappedResetButton(_ sender: UIButton) {
        sender.animated()
        operations.correction()
    }

    /// When the clear button is tapped
    @IBAction func tappedAllResetButton(_ sender: UIButton) {
        sender.animated()
        operations.resetAll()
    }

    /// When any operator button is tapped
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }

        sender.animated()
        operations.addOperator(sender: senderTitle)
    }
}

// MARK: - Notifications actions
extension ViewController {
    /// Display of numbers and operators tapped in textView
    @objc private func actionView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        textView.text = userInfo["TextView"] as? String
    }

    /// Display alert when an action is irrelevant
    @objc private func actionAlert(notification: Notification) {
        var message = "Erreur."

        guard let userInfo = notification.userInfo else { return }

        // Choose the text for each error
        guard let error = userInfo["alert"] as? Notification.Alert else { return }
            switch error {
            case .dotIsAlone:
                message = "Vous devez taper une décimale."
            case .canNotDivideByZero:
                message = "Vous ne pouvez pas diviser par zero."
            case .canNotAddDot:
                message = "Vous ne pouvez pas faire cela."
            case .canNotAddOperator:
                message = "Un opérateur est déja mis."
            case .canNotStartNewCalcul:
                message = "Vous ne pouvez pas commencer un calcul avec cet opérateur."
            case .expressionHaveNotEnoughElement:
                message = "Démarrez un nouveau calcul."
            case .syntaxError:
                message = "Erreur de synthaxe. Veuillez commencer un nouveau calcul."
            case .unknownOperator:
                message = "Opérateur inconnu."
            }

        // Message error
        alertOperator(message: message)
    }
}
