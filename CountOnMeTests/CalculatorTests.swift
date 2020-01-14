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
    /// Property uses for tests
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    // Using XCTAssertEqual for each because in case of error, error message is more explicit.
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

    func testGivenTotalIsTwo_WhenAddingUnkhownOperator_ThenTheTotalIsEqualToZero() {
        let elements = ["2", "?", "1"]
        let calculTest = calculator.calcul(elements: elements)

        XCTAssertEqual(calculTest, "0")
    }

    func testGivenWithLeftDoubleError_Whencalculating_ThenNoResults() {
        let elements = ["t", "+", "1"]
        let calculTest = calculator.calcul(elements: elements)

        XCTAssertEqual(calculTest, "")
    }

    func testGivenWithRightDoubleError_Whencalculating_ThenNoResults() {
        let elements = ["1", "+", "w"]
        let calculTest = calculator.calcul(elements: elements)

        XCTAssertEqual(calculTest, "")
    }
}
