//
//  CalNotesCalculatorTests.swift
//  CalNotesTests
//
//  Created by Jacky Lam on 2023-10-25.
//

import XCTest
@testable import Calculator

final class CalNotesCalculatorTests: XCTestCase {
    var calculator: Calculator = SumTextCalculator(sum: "0")

    override func setUpWithError() throws {
        try super.setUpWithError()
        calculator.reset()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        calculator.reset()
    }

    func testCalculator_AppendDigit() throws {
        calculator.appendDigit(.zero)
        calculator.appendDigit(.zero)
        XCTAssertEqual(calculator.text, "0")
        calculator.appendDigit(.one)
        XCTAssertEqual(calculator.text, "1")
        calculator.appendDigit(.dot)
        calculator.appendDigit(.dot)
        XCTAssertEqual(calculator.text, "1.")
        calculator.appendDigit(.one)
        XCTAssertEqual(calculator.text, "1.1")
    }

    func testCalculator_beginOperation() throws {
        calculator.appendDigit(.two)
        calculator.beginOperation(.plus)
        XCTAssertTrue(calculator.operator == .plus)
        calculator.appendDigit(.three)
        calculator.beginOperation(.multiply)
        XCTAssertTrue(calculator.operator == .plus)
    }

    func testCalculator_Plus() throws {
        calculator.appendDigit(.one)
        calculator.beginOperation(.plus)
        calculator.appendDigit(.one)
        calculator.endOperation()
        XCTAssertEqual(calculator.text, "2")
    }

    func testCalculator_Minus() throws {
        calculator.appendDigit(.one)
        calculator.beginOperation(.minus)
        calculator.appendDigit(.one)
        calculator.endOperation()
        XCTAssertEqual(calculator.text, "0")
    }

    func testCalculator_Multiply() throws {
        calculator.appendDigit(.two)
        calculator.beginOperation(.multiply)
        calculator.appendDigit(.three)
        calculator.endOperation()
        XCTAssertEqual(calculator.text, "6")
    }

    func testCalculator_Divide() throws {
        calculator.appendDigit(.eight)
        calculator.beginOperation(.divide)
        calculator.appendDigit(.two)
        calculator.endOperation()
        XCTAssertEqual(calculator.text, "4")
    }

    func testCalculator_endOperation() throws {
        calculator.appendDigit(.one)
        calculator.beginOperation(.plus)
        calculator.appendDigit(.two)
        calculator.endOperation()
        XCTAssertTrue(calculator.state == .idle)
        XCTAssertEqual(calculator.text, "3")
        calculator.endOperation()
        XCTAssertEqual(calculator.text, "3")
    }

    func testCalculator_EqualDefault() throws {
        calculator.appendDigit(.three)
        calculator.beginOperation(.multiply)
        XCTAssertEqual(calculator.text, "3")
        calculator.endOperation()
        XCTAssertEqual(calculator.text, "9")
    }

    func testCalculator_SwitchOperation() throws {
        calculator.switchOperation(.multiply)
        XCTAssertTrue(calculator.operator == .equal)
        calculator.appendDigit(.two)
        calculator.beginOperation(.plus)
        calculator.switchOperation(.multiply)
        calculator.switchOperation(.equal)
        XCTAssertTrue(calculator.operator == .multiply)
    }

    func testCalculator_ContinueOperation() throws {
        calculator.appendDigit(.two)
        calculator.continueOperation(.multiply)
        XCTAssertTrue(calculator.state == .idle)
        calculator.beginOperation(.plus)
        calculator.continueOperation(.multiply)
        XCTAssertTrue(calculator.text == "2")
        calculator.appendDigit(.three)
        calculator.continueOperation(.equal)
        XCTAssertTrue(calculator.text == "3")
        calculator.continueOperation(.multiply)
        XCTAssertTrue(calculator.text == "5")
        XCTAssertEqual(calculator.state, .progress)
        XCTAssertEqual(calculator.operator, .multiply)
    }

    func testCalcuator_redoLastOperation() throws {
        calculator.appendDigit(.two)
        calculator.redoLastOperation()
        XCTAssertEqual(calculator.text, "2")
        calculator.beginOperation(.multiply)
        calculator.appendDigit(.three)
        calculator.redoLastOperation()
        XCTAssertEqual(calculator.text, "3")
        calculator.endOperation()
        calculator.redoLastOperation()
        XCTAssertEqual(calculator.text, "18")
    }

    func testCalculator_isOperatorSelected() throws {
        XCTAssertFalse(calculator.isOperatorSelected(.plus))
        calculator.beginOperation(.plus)
        XCTAssertTrue(calculator.isOperatorSelected(.plus))
        calculator.appendDigit(.one)
        XCTAssertFalse(calculator.isOperatorSelected(.plus))
        calculator.clear()
        XCTAssertTrue(calculator.isOperatorSelected(.plus))
    }

    func testCalculator_Reset() throws {
        XCTAssertFalse(calculator.isDigitInputted)
        calculator.appendDigit(.two)
        calculator.beginOperation(.plus)
        calculator.appendDigit(.three)
        XCTAssertTrue(calculator.isDigitInputted)
        calculator.reset()
        XCTAssertEqual(calculator.state, .idle)
        XCTAssertEqual(calculator.text, "0")
        XCTAssertFalse(calculator.isDigitInputted)
        XCTAssertFalse(calculator.isCurrDigitInputted)
    }

    func testCalculator_Clear() throws {
        calculator.appendDigit(.two)
        calculator.beginOperation(.plus)
        calculator.appendDigit(.three)
        calculator.clear()
        XCTAssertFalse(calculator.isDigitInputted)
        XCTAssertFalse(calculator.isCurrDigitInputted)
        XCTAssertEqual(calculator.text, "0")
    }

    func testCalculator_InverseSign() throws {
        calculator.appendDigit(.zero)
        calculator.inverseSign()
        XCTAssertEqual(calculator.text, "0")
        calculator.appendDigit(.one)
        calculator.inverseSign()
        XCTAssertEqual(calculator.text, "-1")
        calculator.inverseSign()
        XCTAssertEqual(calculator.text, "1")
    }

    func testCalculator_DeleteBackward() throws {
        calculator.appendDigit(.one)
        calculator.deleteBackward()
        XCTAssertEqual(calculator.text, "0")
        calculator.deleteBackward()
        XCTAssertEqual(calculator.text, "0")
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        calculator.appendDigit(.four)
        calculator.appendDigit(.five)
        calculator.deleteBackward()
        XCTAssertEqual(calculator.text, "234")
    }

    func testCalcuator_Percentaged() throws {
        calculator.percentaged()
        XCTAssertEqual(calculator.text, "0")
        calculator.appendDigit(.one)
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        calculator.appendDigit(.four)
        calculator.appendDigit(.five)
        calculator.percentaged()
        XCTAssertEqual(calculator.text, "123.45")
    }

    func testCalculator_PressButton_Operation() throws {
        calculator.pressButton(.digit(.one))
        XCTAssertTrue(calculator.isDigitInputted)
        calculator.pressButton(.operator(.plus))
        XCTAssertEqual(calculator.state, .progress)
        XCTAssertFalse(calculator.isCurrDigitInputted)
        calculator.pressButton(.digit(.two))
        XCTAssertTrue(calculator.isCurrDigitInputted)
        calculator.pressButton(.operator(.equal))
        XCTAssertEqual(calculator.text, "3")
        calculator.pressButton(.operator(.equal))
        XCTAssertEqual(calculator.text, "5")
        calculator.pressButton(.operator(.divide))
        calculator.pressButton(.operator(.multiply))
        calculator.pressButton(.digit(.three))
        calculator.pressButton(.operator(.minus))
        XCTAssertEqual(calculator.text, "15")
        calculator.pressButton(.digit(.four))
        calculator.pressButton(.operator(.equal))
        XCTAssertEqual(calculator.text, "11")
    }

    func testCalculator_PressButton_Function() throws {
        calculator.appendDigit(.one)
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        calculator.appendDigit(.four)
        calculator.appendDigit(.five)
        calculator.pressButton(.function(.percentage))
        XCTAssertEqual(calculator.text, "123.45")
        calculator.pressButton(.function(.delete))
        XCTAssertEqual(calculator.text, "123.4")
        calculator.pressButton(.function(.inverseSign))
        XCTAssertEqual(calculator.text, "-123.4")
        calculator.pressButton(.function(.clear))
        calculator.pressButton(.function(.delete))
        XCTAssertEqual(calculator.text, "0")
        calculator.appendDigit(.one)
        calculator.pressButton(.function(.allClear))
        XCTAssertEqual(calculator.text, "0")
    }
}
