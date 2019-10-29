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
        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!

            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: fatalError("Unknown operator !")
            }

            let resultTraited = forTrailingZero(temp: result)

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(resultTraited)", at: 0)
        }

        let operationsTotal = operationsToReduce.first!
        return operationsTotal
    }

    func forTrailingZero(temp: Double) -> String {
        let trailingZero = String(format: "%g", temp)
        return trailingZero
    }
}
