//
//  SettingsViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 12/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    static var showCorrectAnswer = true
    
    
    @IBAction func correctAnswer(sender: UISwitch) {
        if sender.on {
            SettingsViewController.showCorrectAnswer = true
        }
        else {
            SettingsViewController.showCorrectAnswer = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
