//
//  Operations.swift
//  CountOnMe
//
//  Created by Elie Arquier on 14/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Operations {
    var numbers = [String]()
    var arrayCalcul = [String]()

    var addNumber: String {
        return numbers.joined()
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
        return numbers.firstIndex(of: ".") != nil
    }

    var canAddOperator: Bool {
        return arrayCalcul.last != "+" && arrayCalcul.last != "-" && arrayCalcul.last != "x"
            && arrayCalcul.last != "/" && arrayCalcul.last != "="
    }

    func addCalcul() {
        arrayCalcul.append(addNumber)
        numbers.removeAll()

        if arrayCalcul.last!.isEmpty {
            arrayCalcul.removeLast()
        }
    }

    func cancelAddCalcul() {
        let cancelCalcul = arrayCalcul.last!

        numbers.append(cancelCalcul)
        arrayCalcul.removeAll()
    }

    func resetCalcul() {
        numbers.removeAll()
        arrayCalcul.removeAll()
    }
}
