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

    /// Enumerations of cases of alert.
    enum Alert {
        case dotIsAlone, canNotDivideByZero, canNotAddDot, canNotAddOperator,
        canNotStartNewCalcul, expressionHaveNotEnoughElement
    }

    /// Return element tapped by user, after validate verifications.
    var element: String = ""{
        didSet {
            viewNotification(textView: element)
        }
    }

    /// Array of element for calculate operation.
    var elements: [String] {
        return element.split(separator: " ").map { "\($0)" }
    }

    // MARK: - Properties use for verifications
    private var expressionHasResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    private var canNotAddDot: Bool {
        return elements.count > 0 && elements.last!.contains(".")
    }

    private var dotIsAlone: Bool {
        return elements.last != "."
    }

    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x"
            && elements.last != "/" && elements.last != "="
    }

    private var canNotDivideByZero: Bool {
        return elements.count >= 2 && elements[elements.count - 2] == "/"
            && (elements.last == "0" || elements.last == "0.")
    }
}

// MARK: - Functions for verifications
extension Validator {
    /// Add number in var element and array elements.
    func addNumbers(numberText: String) {
        verifyResult()

        addNumbersAndDot(senderText: numberText)
    }

    /// Add dot in var element and array elements.
    func addDot(dotText: String) {
        verifyResult()

        guard !canNotAddDot else {
            return alertNotification(userInfo: .canNotAddDot)
        }

        addNumbersAndDot(senderText: dotText)
    }

    /// Add operator in var element and array elements.
    func addOperator(sender: String) {
        verifyResult()

        guard dotIsAlone else {
            return alertNotification(userInfo: .dotIsAlone)
        }

        guard !canNotDivideByZero else {
            return alertNotification(userInfo: .canNotDivideByZero)
        }

        guard canAddOperator else {
            return alertNotification(userInfo: .canNotAddOperator)
        }

        // Add operator uses for the calcul.
        if sender != "=" {
            if elements.isEmpty {
                guard sender == "-" else {
                    return alertNotification(userInfo: .canNotStartNewCalcul)
                }

                /*
                Add "-" whith no space when a new calcul start, for add substraction operator and
                 following number in the same element of the array elements.
                */
                element.append(" \(sender)")
            } else {
                element.append(" \(sender) ")
            }
        // Add equal operator and finish the calcul.
        } else {
            guard expressionHaveEnoughElement else {
                return alertNotification(userInfo: .expressionHaveNotEnoughElement)
            }

            // Terminate calcul
            let operationsTotal = calculator.calcul(elements: elements)

            element.append(" = \(operationsTotal)")
        }
    }

    /// Verify if a possibly previous expression exist and if she has a result.
    private func verifyResult() {
        if expressionHasResult {
            reset()
        }
    }

    /// Suppress all element to start new calcul.
    func reset() {
        element.removeAll()
    }

    /// Add number and dot in element and elements array for the calcul.
    private func addNumbersAndDot(senderText: String) {
        element.append(senderText)
    }
}

// MARK: - Notifications
extension Validator {
    /// If an element has a resolution, a notification is send to the controller to display this element in textView.
    func viewNotification(textView: String) {
        NotificationCenter.default.post(name: .nameView, object: nil, userInfo: ["TextView": textView])
    }

    /// Send notification to controller for displayan error message.
    func alertNotification(userInfo: Alert) {
        NotificationCenter.default.post(name: .nameAlert, object: nil, userInfo: ["alert": userInfo])
    }
}
