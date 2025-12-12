//
//  ViewController.swift
//  SkillBoxUI_1
//
//  Created by Danya on 12.12.2025.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet private weak var counterLabel: UILabel!
    
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    
    @IBAction private func counterButton(_ sender: Any) {
        counter += 1
        counterLabel.text = "Нажатий: \(counter)"
    }
}

