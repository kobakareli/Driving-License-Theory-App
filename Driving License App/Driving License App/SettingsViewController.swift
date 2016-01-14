//
//  SettingsViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 12/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    static var settings = [Bool]()
    
    //static var showCorrectAnswer = true
    
    
    @IBOutlet weak var answerSwitch: UISwitch!
    
    @IBAction func correctAnswer(sender: UISwitch) {
        if sender.on {
            //SettingsViewController.showCorrectAnswer = true
            SettingsViewController.settings[0] = true
            NSUserDefaults.standardUserDefaults().setObject(SettingsViewController.settings, forKey: "LicenseSettings")
        }
        else {
            //SettingsViewController.showCorrectAnswer = false
            SettingsViewController.settings[0] = false
            NSUserDefaults.standardUserDefaults().setObject(SettingsViewController.settings, forKey: "LicenseSettings")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stored = NSUserDefaults.standardUserDefaults().arrayForKey("LicenseSettings") as? [Bool]
        if stored == nil {
            SettingsViewController.settings.append(true)
            NSUserDefaults.standardUserDefaults().setObject(SettingsViewController.settings, forKey: "LicenseSettings")
        }
        else {
            SettingsViewController.settings = stored!
            if SettingsViewController.settings[0] {
                answerSwitch.setOn(true, animated: false)
                //SettingsViewController.showCorrectAnswer = true
            }
            else {
                answerSwitch.setOn(false, animated: false)
                //SettingsViewController.showCorrectAnswer = false
            }
        }

    }

}
