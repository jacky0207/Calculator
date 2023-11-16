//
//  Calculator.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-24.
//

import SwiftUI

protocol Calculator {
    static var defaultValue: String { get }
    var state: CalculationState { get }
    var isDigitInputted: Bool { get }  // control all clear or clear
    var isCurrDigitInputted: Bool { get }  // control input reset "0" and switch operator
    var text: String { get set }
    var `operator`: CalculatorOperator { get }
    // digit
    func appendDigit(_ digit: CalculatorDigit)
    // operator
    func beginOperation(_ operator: CalculatorOperator)
    func switchOperation(_ operator: CalculatorOperator)
    func endOperation()
    func continueOperation(_ operator: CalculatorOperator)
    func redoLastOperation()
    func isOperatorSelected(_ operator: CalculatorOperator) -> Bool
    // function
    func reset()
    func clear()
    func inverseSign()
    func deleteBackward()
    func percentaged()
    // user interaction
    func pressButton(_ type: CalculatorButtonType)
    func pressDigit(_ digit: CalculatorDigit)
    func pressOperator(_ operator: CalculatorOperator)
    func pressFunction(_ function: CalculatorFunction)
}

class SumTextCalculator: ObservableObject, Calculator {
    static var defaultValue: String = "0"

    @Published private(set) var state: CalculationState = .idle
    @Published private(set) var isDigitInputted: Bool = false
    @Published private(set) var isCurrDigitInputted: Bool = false

    // operation
    @Published private var sumText: String = SumTextCalculator.defaultValue
    @Published private(set) var `operator`: CalculatorOperator = .equal
    @Published private var operationText: String = ""

    // change notify
    var onChange: (String) -> Void

    init(
        sum: String,
        onChange: @escaping (String) -> Void = { _ in }
    ) {
        self.sumText = Float(sum) == nil ? SumTextCalculator.defaultValue : sum
        self.onChange = onChange
    }

    // MARK: Text

    var text: String {
        get {
            switch state {
            case .idle:
                return sumText
            case .progress:
                return operationText
            }
        }
        set {
            let newValue = Float(newValue) == nil ? SumTextCalculator.defaultValue : newValue
            switch state {
            case .idle:
                sumText = newValue
                onChange(sumText)
            case .progress:
                operationText = newValue
            }
        }
    }

    private func setText(from value: Float) {
        // case 1: 1.0 -> "1"
        // case 2: 1.1 -> "1.1"
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            text = String(format: "%.0f", value)
            return
        }
        text = String("\(NSNumber(value: value).decimalValue)")
    }

    // MARK: Digit

    func appendDigit(_ digit: CalculatorDigit) {
        if !isCurrDigitInputted {
            clear()  // 1st edit clear operator number first
            isCurrDigitInputted = true
        }
        let newText = CalculatorDigit.concat(text, with: digit)
        if newText == text {
            return
        }
        isDigitInputted = true
        text = newText
    }

    // MARK: Operator

    func beginOperation(_ operator: CalculatorOperator) {
        if state != .idle {
            return
        }
        state = .progress
        isCurrDigitInputted = false
        self.`operator` = `operator`
        operationText = sumText  // default operator number = sum
    }

    private func isSwitchAvailable(for operator: CalculatorOperator) -> Bool {
        if state != .progress || isCurrDigitInputted {
            return false
        }
        switch `operator` {
        case .plus, .minus, .multiply, .divide:
            return self.`operator` != `operator`
        case .equal:
            return false
        }
    }

    func switchOperation(_ operator: CalculatorOperator) {
        if !isSwitchAvailable(for: `operator`) {
            return
        }
        self.`operator` = `operator`
    }

    private func calculate() {
        setText(from: `operator`.calculate(Float(text)!, Float(operationText)!))
    }

    func endOperation() {
        if state != .progress {
            return
        }
        state = .idle
        isCurrDigitInputted = false
        calculate()
    }

    private func isContinueAvailable(for operator: CalculatorOperator) -> Bool {
        if state != .progress || !isCurrDigitInputted {
            return false
        }
        switch `operator` {
        case .plus, .minus, .multiply, .divide:
            return true
        case .equal:
            return false
        }
    }

    func continueOperation(_ operator: CalculatorOperator) {
        if !isContinueAvailable(for: `operator`) {
            return
        }
        endOperation()
        beginOperation(`operator`)  // operator combo
    }

    func redoLastOperation() {
        if state != .idle || `operator` == .equal {
            return
        }
        calculate()
    }

    func isOperatorSelected(_ operator: CalculatorOperator) -> Bool {
        return state == .progress
        && (!isCurrDigitInputted && (text == SumTextCalculator.defaultValue || sumText == operationText))
        && self.`operator` == `operator`
    }

    // MARK: Function

    func reset() {
        state = .idle
        isDigitInputted = false
        isCurrDigitInputted = false
        sumText = SumTextCalculator.defaultValue
        `operator` = .equal
        operationText = ""
        onChange(sumText)  // reset modify origin text directly
    }

    func clear() {
        isDigitInputted = false
        isCurrDigitInputted = false
        text = SumTextCalculator.defaultValue
    }

    func inverseSign() {
        if text == SumTextCalculator.defaultValue {
            return
        }
        setText(from: -Float(text)!)
    }

    func deleteBackward() {
        if text == SumTextCalculator.defaultValue {
            return
        }
        text = String(text.dropLast())
    }

    func percentaged() {
        if text == SumTextCalculator.defaultValue {
            return
        }
        isCurrDigitInputted = false
        setText(from: Float(text)! / 100)
    }

    // MARK: User Interaction

    func pressButton(_ type: CalculatorButtonType) {
        switch type {
        case .digit(let type):
            pressDigit(type)
        case .operator(let type):
            pressOperator(type)
        case .function(let type):
            pressFunction(type)
        }
    }

    func pressDigit(_ digit: CalculatorDigit) {
        appendDigit(digit)
        print("digit: \(digit), text: \(text)")
    }

    func pressOperator(_ operator: CalculatorOperator) {
        switch state {
        case .idle:
            switch `operator` {
            case .plus, .minus, .multiply, .divide:
                // select operator
                beginOperation(`operator`)
            case .equal:
                redoLastOperation()
            }
        case .progress:
            switch `operator` {
            case .plus, .minus, .multiply, .divide:
                if isCurrDigitInputted {
                    continueOperation(`operator`)
                } else {
                    switchOperation(`operator`)
                }
            case .equal:
                endOperation()
            }
        }
        print("operator: \(`operator`), text: \(text)")
    }

    func pressFunction(_ function: CalculatorFunction) {
        switch function {
        case .allClear:
            reset()
        case .clear:
            clear()
        case .inverseSign:
            inverseSign()
        case .delete:
            deleteBackward()
        case .percentage:
            percentaged()
        }
        print("function: \(function), text: \(text)")
    }
}
