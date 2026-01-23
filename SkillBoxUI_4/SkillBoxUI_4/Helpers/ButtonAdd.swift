//
//  buttonAdd.swift
//  SkillBoxUI_4
//
//  Created by Danya on 17.01.2026.
//

import UIKit

///Данные кнопки
struct ButtonViewModel {
    let type: ButtonType
    let backgroundColor: UIColor
    let actionType : ActionType
    
    init(type: ButtonType, backgroundColor: UIColor = .systemOrange, actionType: ActionType) {
        self.type = type
        self.backgroundColor = backgroundColor
        self.actionType = actionType
    }
    
    enum ButtonType {
        case text(String)
        case image(_ systemName: String)
    }
    
    enum ActionType {
        case number
        case operation
        case equality
        case other
    }
}

extension UIButton {
    convenience init(_ model: ButtonViewModel) {
        self.init(frame: .zero)
        backgroundColor = model.backgroundColor
        switch model.type {
        case .text(let text):
            setTextState(text)
        case .image(let image):
            setImage(image)
        }
    }
    
    ///Вкладываем текст в кнопку
    private func setTextState(_ title: String) {
        makeBaseButton()
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 35, weight: .medium)
        setTitleColor(.white, for: .normal)
    }
    
    ///Вкладываем картинку в кнопку
    private func setImage(_ image: String) {
        makeBaseButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        let image = UIImage(systemName: image, withConfiguration: config)!
        setImage(image, for: .normal)
        tintColor = .white
    }
    
    ///Устанавливаем размер кнопкам
    private func makeBaseButton() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 40
        NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: 90),
                                     heightAnchor.constraint(equalToConstant: 90)])
    }
}
