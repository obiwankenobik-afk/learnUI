//
//  CalculatorPresenter.swift
//  SkillBoxUI_4
//
//  Created by Danya on 18.02.2026.
//

import Foundation

final class CalculatorPresenter: CalculatorPresenterProtocol {
    
    weak var view: CalculatorViewProtocol?
    private let model: CalculatorModel
    
    init(view: CalculatorViewProtocol, model: CalculatorModel = CalculatorModel()) {
        self.view = view
        self.model = model
    }
    
    func numberPressed(_ number: String) {
        model.numberPressed(number)
        view?.updateDisplay(text: model.displayText)
    }
    
    func operationPressed(_ operation: MathOperation) {
        model.activeComputing(operation)
        view?.updateDisplay(text: model.displayText)
    }
    
    func equalityPressed() {
        model.equalityPressed()
        view?.updateDisplay(text: model.displayText)
    }
    
    func otherOperationPressed(_ operation: OtherOperation) {
        model.otherOperation(operation)
        view?.updateDisplay(text: model.displayText)
    }
    
    func viewDidLoad() {
        view?.updateDisplay(text: model.displayText)
    }
}
