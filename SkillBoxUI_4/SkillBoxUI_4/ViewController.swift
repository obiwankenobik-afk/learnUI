//
//  ViewController.swift
//  SkillBoxUI_4
//
//  Created by Danya on 17.01.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    ///Лейбл над кнопками
    private let displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 75)
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ///Главная вьюха для кнопок
    private let buttonsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    ///Массив для кнопок
    private let rowsButton: [[(title: String?, systemImage: String?, backgroundColor: UIColor?)]] =
    [[(nil, "delete.left", .systemGray),
      ("AC", nil, .systemGray),
      ("%", nil, .systemGray),
      ("÷", nil, .systemOrange)],
     
     [("7", nil, .darkGray),
      ("8", nil, .darkGray),
      ("9", nil, .darkGray),
      ("×", nil, .systemOrange)],
     
     [("4", nil, .darkGray),
      ("5", nil, .darkGray),
      ("6", nil, .darkGray),
      ("+", nil, .systemOrange)],
     
     [("1", nil, .darkGray),
      ("2", nil, .darkGray),
      ("3", nil, .darkGray),
      ("-", nil, .systemOrange)],
     
     [("+/-", nil, .darkGray),
      ("0", nil, .darkGray),
      (".", nil, .darkGray),
      ("=", nil, .systemOrange)]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupConstraints()
        makerButtons()
        
    }
    
    ///Устанавливаем ограничения для лейбла и для вьюхи кнопок
    private func setupConstraints() {
        view.addSubview(displayLabel)
        view.addSubview(buttonsStack)
        
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        displayLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        displayLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        buttonsStack.setContentHuggingPriority(.defaultHigh, for: .vertical)
        buttonsStack.setContentHuggingPriority(.required, for: .vertical)
        
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
    
    ///Создаем кнопки и запихиваем их во вьюхи
    private func makerButtons() {
        let maker = ButtonAdd()
        
        for row in rowsButton {
            var buttons: [UIButton] = []
            
            for item in row {
                let button = maker.makeButton(title: item.title, systemImage: item.systemImage, backgroundColor: item.backgroundColor)
                buttons.append(button)
            }
            
            let rowStack = UIStackView(arrangedSubviews: buttons)
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 6
            
            buttonsStack.addArrangedSubview(rowStack)
        }
    }
}

#Preview {
    ViewController()
}
