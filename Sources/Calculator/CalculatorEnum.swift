//
//  CalculatorEnum.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-25.
//

enum CalculationState {
    case idle
    case progress
}

enum CalculatorButtonType {
    case digit(_ digit: CalculatorDigit)
    case `operator`(_ operator: CalculatorOperator)
    case function(_ function: CalculatorFunction)
}

enum CalculatorDigit {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case dot
}

enum CalculatorOperator {
    case plus
    case minus
    case multiply
    case divide
    case equal
}

enum CalculatorFunction {
    case allClear
    case clear
    case inverseSign
    case delete
    case percentage
}
