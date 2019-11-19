//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var operations = Operations()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:
            #selector(actionView(notification:)), name: .nameView, object: nil)

        NotificationCenter.default.addObserver(self, selector:
            #selector(actionAlert(notification:)), name: .nameAlert, object: nil)
    }
}

extension ViewController {
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        sender.animated()
        operations.addNumbers(numberText: numberText)
    }

    @IBAction func tappedDotButton(_ sender: UIButton) {
        guard let dotText = sender.title(for: .normal) else { return }

        sender.animated()
        operations.addDot(dotText: dotText)
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        sender.animated()
        operations.reset()
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }

        sender.animated()
        operations.addOperator(senderTitle: senderTitle)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard let equalText = sender.currentTitle else { return }

        sender.animated()
        operations.terminateCalcul(sender: equalText)
    }
}

extension ViewController {
    @objc private func actionView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        textView.text = userInfo["TextView"] as? String
    }

    @objc private func actionAlert(notification: Notification) {
        var message: String!

        guard let userInfo = notification.userInfo else { return }

        guard let error = userInfo["alert"] as? Operations.Alert else { return }
            switch error {
            case .canNotDivideByZero:
                message = "Vous ne pouvez pas diviser par zero !"
            case .canAddDot:
                message = "Vous ne pouvez pas faire cela !"
            case .canAddOperator:
                message = "Un operateur est déja mis !"
            case .canTerminateCalcul:
                message = "Entrez une expression correcte  !"
            case .expressionHaveEnoughElement:
                message = "Démarrez un nouveau calcul !"
            }
        alertOperator(message: message)
    }

    private func alertOperator(message: String) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
