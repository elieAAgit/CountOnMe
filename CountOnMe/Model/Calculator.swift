//
//  Calculator.swift
//  CountOnMe
//
//  Created by Elie Arquier on 29/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    func calcul(elements: [String]) -> String {
        // Create local copy of operations.
        var operationsToReduce = elements

        // Iterate over operations while an operand still here.
        while operationsToReduce.count > 1 {
            var left: Double!
            var right: Double!
            var operand: String!
            var operandIndex: Int!

            // Verify the operators priority.
            if let index = operationsToReduce.firstIndex(where: {$0 == "x" || $0 == "/"}) {
                left = Double(operationsToReduce[index - 1])!
                operand = operationsToReduce[index]
                operandIndex = index - 1
                right = Double(operationsToReduce[index + 1])!
            } else if let index = operationsToReduce.firstIndex(where: {$0 == "+" || $0 == "-"}) {
                left = Double(operationsToReduce[index - 1])!
                operand = operationsToReduce[index]
                operandIndex = index - 1
                right = Double(operationsToReduce[index + 1])!
            }

            let result: Double
            switch operand {
            case "x": result = left * right
            case "/": result = left / right
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }

            let resultTraited = forTrailingZero(temp: result)

            // Insert the result of the calcul in place of numbers and operator of the calcul.
            operationsToReduce.removeSubrange(ClosedRange(uncheckedBounds:
                (lower: operandIndex, upper: operandIndex + 2)))
            operationsToReduce.insert("\(resultTraited)", at: operandIndex)
        }

        let operationsTotal = operationsToReduce.first!
        return operationsTotal
    }

    // Remove unused zero and dot.
    private func forTrailingZero(temp: Double) -> String {
        let trailingZero = String(format: "%g", temp)
        return trailingZero
    }
}
