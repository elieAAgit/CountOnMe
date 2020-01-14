//
//  Calculator.swift
//  CountOnMe
//
//  Created by Elie Arquier on 29/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    /// Calculate the result of the operation
    func calcul(elements: [String]) -> String {
        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var operandIndex: Int

            // Operations priority: first multiply or divide
            if let index = operationsToReduce.firstIndex(where: {$0 == "x" || $0 == "/"}) {
                operandIndex = index
            // After: add or subtract
            } else if let index = operationsToReduce.firstIndex(where: {$0 == "+" || $0 == "-"}) {
                operandIndex = index
            /*
              If unknown operator, set a default value to operand index
              Default value is 1 because the loop only starts with count > 1
            */
            } else {
                operandIndex = 1
            }

            // Transform String operation to reduce in Double for the calcul
            guard let left = Double(operationsToReduce[operandIndex - 1]) else {
                Notification.alertNotification(userInfo: .syntaxError)
                return ""
            }

            guard let right = Double(operationsToReduce[operandIndex + 1]) else {
                Notification.alertNotification(userInfo: .syntaxError)
                return ""
            }

            // Recovery of the calculation operator
            let calculationOperator = operationsToReduce[operandIndex]

            // Do the math
            let result: Double
            switch calculationOperator {
            case "x": result = left * right
            case "/": result = left / right
            case "+": result = left + right
            case "-": result = left - right
            default: result = 0
                Notification.alertNotification(userInfo: .unknownOperator)
            }

            // Remove the decimal point and the trailing zero
            let resultTraited = forTrailingZero(temp: result)

            // Replace the left number by the new result and remove the operator and the right number
            operationsToReduce.removeSubrange(ClosedRange(uncheckedBounds:
                (lower: operandIndex - 1, upper: operandIndex + 1)))
            operationsToReduce.insert("\(resultTraited)", at: operandIndex - 1)
        }

        // Return the result of the calcul
        let operationsTotal = operationsToReduce.first!
        return operationsTotal
    }

    /// Remove the decimal point and the trailing zero
    private func forTrailingZero(temp: Double) -> String {
        let trailingZero = String(format: "%g", temp)
        return trailingZero
    }
}
