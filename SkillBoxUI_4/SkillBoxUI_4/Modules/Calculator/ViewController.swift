//
//  ViewController.swift
//  SkillBoxUI_4
//
//  Created by Danya on 17.01.2026.
//

import UIKit

final class ViewController: UIViewController {
    private let logic = ButtonLogic()
    ///Лейбл над кнопками
    private lazy var displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 75)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ///Главная вьюха для кнопок
    private lazy var buttonsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    ///Устанавливаем вьюху, констрейты + кнопки
    private let rowsButton: [[ButtonViewModel]] = CalculatorButtonsFactory.makeRows()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        makerButtons()
        
    }
}

private extension ViewController {
    ///Делаем вью и накидываем на нее лейбл и кнопки
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(displayLabel)
        view.addSubview(buttonsStack)
        buttonsStack.setContentHuggingPriority(.defaultHigh, for: .vertical)
        buttonsStack.setContentHuggingPriority(.required, for: .vertical)
    }
    
    ///Устанавливаем ограничения для лейбла и для вьюхи кнопок
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            displayLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            buttonsStack.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    ///Привязываем кнопки к дейтсвиям
    private func makerButtons() {
        for row in rowsButton {
            var buttons: [UIButton] = []
            
            for item in row {
                let button = UIButton(item)
                
                switch item.actionType {
                case .number:
                    button.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                case .operation:
                    button.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
                case .equality:
                    button.addTarget(self, action: #selector(equalityPressed(_:)), for: .touchUpInside)
                case .other:
                    button.addTarget(self, action: #selector(otherOperationPressed(_:)), for: .touchUpInside)
                } 
                buttons.append(button)
            }
            
            let rowStack = UIStackView(arrangedSubviews: buttons)
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 6
            
            buttonsStack.addArrangedSubview(rowStack)
        }
    }
    
    @objc private func numberPressed(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        logic.numberPressed(digit)
        updateDisplay()
    }
    
    @objc private func operationPressed(_ sender: UIButton) {
        guard let symbol = sender.titleLabel?.text,
              let operation = MathOperation(rawValue: symbol) else { return }
        
        logic.activeComputing(operation)
        updateDisplay()
    }
    
    @objc private func equalityPressed(_ sender: UIButton) {
        logic.equalityPressed()
        updateDisplay()
    }
    
    @objc private func otherOperationPressed(_ sender: UIButton) {
        if let title = sender.titleLabel?.text,
           let operation = OtherOperation(rawValue: title) {
            logic.calculateOtherOperation(operation)
        } else {
            logic.calculateOtherOperation(.deleteLastNumber)
        }
        updateDisplay()
    }
    
    private func updateDisplay() {
        displayLabel.text = logic.displayText
    }
}

#Preview {
    ViewController()
}

