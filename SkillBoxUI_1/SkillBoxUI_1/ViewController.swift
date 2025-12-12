//
//  ViewController.swift
//  SkillBoxUI_1
//
//  Created by Danya on 12.12.2025.
//

import UIKit
class ViewController: UIViewController {
    var counter = 0
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBAction func counterButton(_ sender: Any) {
        counter += 1
        counterLabel.text = "Нажатий: \(counter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

