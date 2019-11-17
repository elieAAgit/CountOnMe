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
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        operations.addNumbers(numberText: numberText)
    }

    @IBAction func tappedDotButton(_ sender: UIButton) {
        guard let dotText = sender.title(for: .normal) else { return }
        
        operations.addDot(dotText: dotText)
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        operations.reset()
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }

        operations.addOperator(senderTitle: senderTitle)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard let equalText = sender.currentTitle else { return }
        
        operations.terminateCalcul(sender: equalText)
    }

    private func alertOperator(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
