//
//  WarningViewController.swift
//  SkillBoxUI_3
//
//  Created by Danya on 05.01.2026.
//

import UIKit
final class WarningViewController: UIViewController {
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        showLastScreenAlert()
    }
}

private extension WarningViewController {
    
    func showLastScreenAlert() {
        let alert = UIAlertController(title: "Последний экран", message: "Это последний экран в данной вкладке", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ок", style: .default)

        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
