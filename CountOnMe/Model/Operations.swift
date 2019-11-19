//
//  Operations.swift
//  CountOnMe
//
//  Created by Elie Arquier on 14/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Operations {
    var calculator = Calculator()

    enum Alert {
        case canNotDivideByZero, canAddDot, canAddOperator, canTerminateCalcul, expressionHaveEnoughElement
    }

    var element: String = ""{
        didSet {
            viewNotification(textView: element)
        }
    }

    var arrayCalcul: [String] {
        return element.split(separator: " ").map { "\($0)" }
    }

    var expressionHaveResult: Bool {
        return arrayCalcul.firstIndex(of: "=") != nil
    }

    // Error check computed variables
    var expressionHaveOneOperator: Bool {
        return arrayCalcul.firstIndex(of: "+") != nil && arrayCalcul.firstIndex(of: "-") != nil
            && arrayCalcul.firstIndex(of: "x") != nil && arrayCalcul.firstIndex(of: "/") != nil
    }

    var expressionHaveEnoughElement: Bool {
        return arrayCalcul.count >= 3
    }

    var canAddDot: Bool {
        if arrayCalcul.count > 0 {
            return arrayCalcul.last!.contains(".")
        }
        return false
    }

    var canAddOperator: Bool {
        return arrayCalcul.last != "+" && arrayCalcul.last != "-" && arrayCalcul.last != "x"
            && arrayCalcul.last != "/" && arrayCalcul.last != "="
    }
}

extension Operations {
    func addNumbers(numberText: String) {
        if expressionHaveResult {
            reset()
        } else if arrayCalcul.last == "/" && numberText == "0" {
            return alertNotification(userInfo: .canNotDivideByZero)
        }

        addNumbersAndDot(senderText: numberText)
    }

    func addDot(dotText: String) {
        if expressionHaveResult {
            reset()
        } else if canAddDot != true {
            addNumbersAndDot(senderText: dotText)
        } else {
            alertNotification(userInfo: .canAddDot)
        }
    }

    func addOperator(senderTitle: String) {
        if expressionHaveResult {
            reset()

            if senderTitle == "-" {
                element.append("\(senderTitle)")
            }
        } else if arrayCalcul.isEmpty && senderTitle != "-" {
            return
        } else if arrayCalcul.isEmpty && senderTitle == "-" {
            element.append("\(senderTitle)")
        } else if canAddOperator {
            element.append(" \(senderTitle) ")
        } else {
            alertNotification(userInfo: .canAddOperator)
        }
    }

    func terminateCalcul(sender: String) {
        if expressionHaveResult {
            reset()
        }

        guard canAddOperator else {
            return alertNotification(userInfo: .canTerminateCalcul)
        }

        guard expressionHaveEnoughElement else {
            if arrayCalcul.isEmpty {
                return
            }

            return alertNotification(userInfo: .expressionHaveEnoughElement)
        }

        let calcul = arrayCalcul
        let operationsTotal = calculator.calcul(elements: calcul)

        element.append(" = \(operationsTotal)")
        print(arrayCalcul)
    }

    private func addNumbersAndDot(senderText: String) {
        element.append(senderText)
    }

    func reset() {
        element.removeAll()
    }
}

extension Operations {
    func viewNotification(textView: String) {
        NotificationCenter.default.post(name: .nameView, object: nil, userInfo: ["TextView": textView])
    }

    func alertNotification(userInfo: Alert) {
        NotificationCenter.default.post(name: .nameAlert, object: nil, userInfo: ["alert": userInfo])
    }
}
