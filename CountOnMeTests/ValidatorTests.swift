//
//  ValidatorTests.swift
//  CountOnMeTests
//
//  Created by Elie Arquier on 26/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class ValidatorTests: XCTestCase {
    /// Property uses for tests
    var validation: Validator!

    override func setUp() {
        validation = Validator()
    }

    // MARK: - Numbers tests
    func testGivenElementsHasEqual_whenNumberButtonIsTapped_thenElementsIsreseted() {
        validation.element = "="

        validation.addNumbers(numberText: "1")

        XCTAssertTrue(validation.elements == ["1"])
    }

    // MARK: - Dot tests
    func testGivenNumbersHasNoDot_whenAddot_theCanAddDot() {
        validation.element = "1"

        validation.addDot(dotText: ".")

        XCTAssertTrue(validation.elements == ["1."])
    }

    func testGivenElementsHasEqual_whenDotButtonIsTapped_thenElementsIsreseted() {
        validation.element = "="

        validation.addDot(dotText: ".")

        XCTAssertTrue(validation.elements == ["."])
    }

    func testGivenExpressionHasDot_whenAddDot_thenCanNotAddDot() {
        validation.element = "."

        validation.addDot(dotText: ".")

        XCTAssertFalse(validation.elements == [".", "."])
    }

    // MARK: - Reset test

    func testGivenCorrectionUserAction_whenCorrectionIsTapped_thenLastElementIsSuppress() {
        validation.element = "3 + 21"

        validation.correction()

        XCTAssertEqual(validation.elements.last, "2")
    }

    func testGivenCorrectionUserAction_whenCalculHasResult_thenAllElementsAreSuppress() {
        validation.element = "3 + 21 = 24"

        validation.correction()

        XCTAssertEqual(validation.elements, [])
    }

    // MARK: - Operators none equal tests
    func testGivenDotHasTapped_whenDotIsAlone_thenOperatorIsNotAdded() {
        validation.element = "."

        validation.addOperator(sender: "+")

        XCTAssertEqual(validation.elements.last, ".")
    }

    func testGivenLastElementIsNotAnOperator_whenAddingAnOperator_thenOperatorIsAddingWithSuccess() {
        validation.element = "1"

        validation.addOperator(sender: "x")

        XCTAssertEqual(validation.elements.last, "x")
    }

    func testGivenLastElementIsAnOperator_whenAddingOperator_thenOperatorIsNotAdding() {
        validation.element = "1 +"

        validation.addOperator(sender: "/")

        XCTAssertEqual(validation.elements.last, "+")
    }

    func testGivenElementsIsEmpty_whenOperatorNoneSubstractionIsTapped_theOperatorIsNotAdded() {
        validation.addOperator(sender: "+")

        XCTAssertTrue(validation.elements == [])
    }

    func testGivenElementsIsEmpty_whenSubstractionButtonIsTapped_thenSubstractionIsAdded() {
        validation.addOperator(sender: "-")

        XCTAssertTrue(validation.elements == ["-"])
    }

    func testGivenElementsHasEqual_whenNoneSubstractionOperatorIsTapped_thenElementsIsreseted() {
        validation.element = "="

        validation.addOperator(sender: "+")

        XCTAssertTrue(validation.elements == [])
    }

    func testGivenElementsHasEqual_whenSubstractionIsTapped_thenElementsIsresetedAndSubstractionAdded() {
        validation.element = "="

        validation.addOperator(sender: "-")

        XCTAssertTrue(validation.elements == ["-"])
    }

    // MARK: - Equal tests
    func testGivenDotHasTapped_whenDotIsAlone_thenCalculIsNotFinish() {
        validation.element = "1 - ."

        validation.addOperator(sender: "=")

        XCTAssertEqual(validation.elements.last, ".")
    }

    func testGivenExpressionHasNoThreeElements_whenTryedTerminateCalcul_ThenCalculFail() {
        validation.element = "1 1"

        validation.addOperator(sender: "=")

        XCTAssertLessThan(validation.elements.count, 3)
    }

    func testGivenExpressionIsCorrect_whenTryedTerminateCalcul_thenCalculIsTerminatedWithSuccess() {
        validation.element = "1 + 1"

        validation.addOperator(sender: "=")

        XCTAssertTrue(validation.elements == ["1", "+", "1", "=", "2"])
    }

    // MARK: - Division test
    func testGivenHasNumber_whenTryedToDivideByZero_thenCanNotAddAnotherOperator() {
        validation.element = "2 / 0.0"

        validation.addOperator(sender: "+")

        XCTAssertEqual(validation.elements.last, "0.0")
    }

    func testGivenHasNumber_whenTryedToDivideByPositiveNumber_thenCanAddAnotherOperator() {
        validation.element = "2 / 0.0001"

        validation.addOperator(sender: "+")

        XCTAssertEqual(validation.elements.last, "+")
    }
}
