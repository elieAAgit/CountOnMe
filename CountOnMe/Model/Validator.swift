//
//  Validator.swift
//  CountOnMe
//
//  Created by Elie Arquier on 26/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Validator {
    private var calculator = Calculator()

    /// Return element tapped by user, after validate verifications
    var element: String = ""{
        didSet {
            Notification.viewNotification(textView: element)
        }
    }

    /// Array of element for calculate operation
    var elements: [String] {
        return element.split(separator: " ").map { "\($0)" }
    }

    // MARK: Properties
    private var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }

    /// Check that the expression has at least 3 elements
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    /// Check that there is no point already
    private var canNotAddDot: Bool {
        return elements.count > 0 && elements.last!.contains(".")
    }

    ///Check that the expression has at least one more element
    private var dotIsNotAlone: Bool {
        return elements.last != "."
    }

    /// Check that the last element of the expression is not an operator
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x"
            && elements.last != "/" && elements.last != "="
    }

    /// Check that the operation not contains a division by zero
    private var canDivideByZero: Bool {
        // check that the operation is a division and elements have enough element
        if elements.count > 2 && elements[elements.count - 2] == "/" {
            // Numbers are required for a divsion
            let requiredList = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
            // Create an array with last element on elements array
            var controlForDivide = [String()]
            // Force-unwrap using '!' : in this 'if' we KNOW elements.count is superior to 2
            let last = elements.last!

            for element in last {
                controlForDivide.append(String(element))
            }

            // If an element of requiredList is present in controlForDivide, then division is allowed
            if requiredList.contains(where: controlForDivide.contains) {
                return true
            } else {
                return false
            }
        }

        return true
    }
}

// MARK: Functions
extension Validator {
    /// Add number in property element and array elements
    func addNumbers(numberText: String) {
        verifyHaveResult()

        addNumbersAndDot(senderText: numberText)
    }

    /// Add dot in property element and array elements
    func addDot(dotText: String) {
        verifyHaveResult()

        guard canNotAddDot != true else {
            return Notification.alertNotification(userInfo: .canNotAddDot)
        }

        addNumbersAndDot(senderText: dotText)
    }

    /// Correct last element
    func correction() {
        if expressionHaveResult {
            resetAll()
        } else {
            element.removeLast()
        }
    }

    /// Suppress all element to start new calcul
    func resetAll() {
        element.removeAll()
    }

    /// If previous calcul have result then clear all before start new calcul
    private func verifyHaveResult() {
        if expressionHaveResult {
            resetAll()
        }
    }

    /// Append property element and array elements with user choice
    private func addNumbersAndDot(senderText: String) {
        element.append(senderText)
    }

    /// Add opereator in var element and array elements
    func addOperator(sender: String) {
        verifyHaveResult()

        guard dotIsNotAlone else {
            return Notification.alertNotification(userInfo: .dotIsAlone)
        }

        guard canDivideByZero else {
            return Notification.alertNotification(userInfo: .canNotDivideByZero)
        }

        guard canAddOperator else {
            return Notification.alertNotification(userInfo: .canNotAddOperator)
        }

        if sender == "=" {
            guard expressionHaveEnoughElement else {
                return Notification.alertNotification(userInfo: .expressionHaveNotEnoughElement)
            }

            // Do the math
            let operationsTotal = calculator.calcul(elements: elements)

            // Display calcul result
            element.append(" = \(operationsTotal)")
        // If operator is not '='
        } else {
            // When a calculation begins and operator is not '-', no addition of operator
            if elements.isEmpty && sender != "-" {
                return Notification.alertNotification(userInfo: .canNotStartNewCalcul)
            }

            // When a calculation begins and operator is '-', add the operator without space at the beginning
            if elements.isEmpty && sender == "-" {
                element.append(" \(sender)")
            // During the calculation, add the operator, with spaces
            } else {
                element.append(" \(sender) ")
            }
        }
    }
}
