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
    
    var element: String = ""

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
        return arrayCalcul.last!.contains(".")
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
            return
        }

        addNumbersAndDot(senderText: numberText)
    }

    func addDot(dotText: String) {
        if expressionHaveResult {
            reset()
        } else if canAddDot != true {
            addNumbersAndDot(senderText: dotText)
        } else {
            
        }
    }

    func addOperator(senderTitle: String) {
        if expressionHaveResult && senderTitle == "-" {
            reset()
            element.append("\(senderTitle)")
        } else if expressionHaveResult {
            reset()
        } else if arrayCalcul.isEmpty && senderTitle != "-" {
            return
        } else if arrayCalcul.isEmpty && senderTitle == "-" {
            element.append("\(senderTitle)")
        } else if canAddOperator {
            element.append(" \(senderTitle) ")
        } else {
            
        }
    }

    func terminateCalcul(sender: String) {
        if expressionHaveResult {
            reset()
        }

        guard canAddOperator else {
            return
        }

        guard expressionHaveEnoughElement else {
            if arrayCalcul.isEmpty {
                return
            } else {
                reset()
            }

            return
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
