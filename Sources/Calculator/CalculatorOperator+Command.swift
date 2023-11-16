//
//  CalculatorOperator+Calculation.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-25.
//

extension CalculatorOperator {
    func calculate(_ a: Float, _ b: Float) -> Float {
        switch self {
        case .plus:
            return a + b
        case .minus:
            return a - b
        case .multiply:
            return a * b
        case .divide:
            return a / b
        case .equal:
            fatalError("Calculation doest not supported for equal operator")
        }
    }
}
