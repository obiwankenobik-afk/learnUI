//
//  CalculatorPresenterProtocol.swift
//  SkillBoxUI_4
//
//  Created by Danya on 18.02.2026.
//

import Foundation

protocol CalculatorPresenterProtocol {
    func numberPressed(_ number: String)
    func operationPressed(_ operation: MathOperation)
    func equalityPressed()
    func otherOperationPressed(_ operation: OtherOperation)
}
