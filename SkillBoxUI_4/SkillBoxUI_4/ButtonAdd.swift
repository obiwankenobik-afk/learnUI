//
//  buttonAdd.swift
//  SkillBoxUI_4
//
//  Created by Danya on 17.01.2026.
//

import UIKit

final class ButtonAdd: UIButton {
    
    ///Создаем кнопочки и устанавливаем им размер
    func makeButton(title: String? = nil, systemImage: String? = nil, backgroundColor: UIColor? = nil) -> UIButton {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let title {
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 35, weight: .medium)
            button.setTitleColor(.white, for: .normal)
        }
        
        if let systemImage {
            let config = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)
            button.setImage(
                UIImage(systemName: systemImage, withConfiguration: config), for: .normal)
            button.tintColor = .white
        }
        
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 40
        
        NSLayoutConstraint.activate([button.widthAnchor.constraint(equalToConstant: 90),
            button.heightAnchor.constraint(equalToConstant: 90)])
        
        return button
    }
}

#Preview {
    ViewController()
}
