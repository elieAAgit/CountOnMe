//
//  CalculatorTests.swift
//  CountOnMeTests
//
//  Created by Elie Arquier on 26/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {
    /// Property use for tests
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    // Using XCTAssertEqual for each because in case of error, message error is more explicit.
    func testGivenTotalIsNul_WhenMakingAnAdditionOnePlusOne_ThenTheTotalIsEqualToTwo() {
        let elements = ["1", "+", "1"]
        let calculTest = calculator.calcul(elements: elements)

        XCTAssertEqual(calculTest, "2")
    }

    func testGivenTotalIsTwo_WhenMakingAnsoustractionTwoByOne_ThenTheTotalIsEqualToOne() {
        let elements = ["2", "-", "1"]
        let calculTest = calculator.calcul(elements: elements)

        XCTAssertEqual(calculTest, "1")
    }

    func testGivenTotalIsOne_WhenMakingAnMultiplicationOneByTwo_ThenTheTotalIsEqualToTwo() {
        let elements = ["1", "x", "2"]
        let calculTest = calculator.calcul(elements: elements)

        XCTAssertEqual(calculTest, "2")
    }

    func testGivenTotalIsTwo_WhenMakingAnDivisionTwoByOne_ThenTheTotalIsEqualToTwo() {
        let elements = ["2", "/", "1"]
        let calculTest = calculator.calcul(elements: elements)

        XCTAssertEqual(calculTest, "2")
    }
}
