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
    var calculator = Calculator()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }

        if operations.expressionHaveResult {
            reset()
        }

        addNumbersAndDot(senderText: numberText)
    }

    @IBAction func tappedDotButton(_ sender: UIButton) {
        guard let dotText = sender.title(for: .normal) else {
            return
        }

        if operations.canAddDot != true {
            addNumbersAndDot(senderText: dotText)
        } else {
            let message = "Vous ne pouvez pas faire cela !"

            alertOperator(message: message)
        }
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        reset()
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        operations.addCalcul()

        if operations.canAddOperator {
            guard let senderTitle = sender.currentTitle else {
                return
            }

            textView.text.append(" \(senderTitle) ")
            operations.arrayCalcul.append("\(senderTitle)")
        } else {
            let message = "Un operateur est déja mis !"

            alertOperator(message: message)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        operations.addCalcul()

        guard operations.canAddOperator else {
            let message = "Entrez une expression correcte  !"

            return alertOperator(message: message)
        }

        guard operations.expressionHaveEnoughElement else {
            if operations.arrayCalcul.isEmpty {
                return
            } else {
                operations.cancelAddCalcul()
            }

            let message = "Démarrez un nouveau calcul !"

            return alertOperator(message: message)
        }

        let calcul = operations.arrayCalcul
        let operationsTotal = calculator.calcul(elements: calcul)
        print(calcul)

        textView.text.append(" = \(operationsTotal)")
        operations.arrayCalcul.append("=")
    }

    private func addNumbersAndDot(senderText: String) {
        textView.text.append(senderText)
        operations.numbers.append(senderText)
    }

    private func reset() {
        textView.text = ""
        operations.resetCalcul()
    }

    private func alertOperator(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
