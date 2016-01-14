//
//  ViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 07/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let stored = NSUserDefaults.standardUserDefaults().arrayForKey("LicenseSettings") as? [Bool]
        if stored == nil {
            SettingsViewController.settings.append(true)
            NSUserDefaults.standardUserDefaults().setObject(SettingsViewController.settings, forKey: "LicenseSettings")
        }
        else {
            SettingsViewController.settings = stored!
        }
        let stats = NSUserDefaults.standardUserDefaults().arrayForKey("LicenseStats") as? [Int]
        if stats == nil {
            for var i = 0; i < 4; i++ {
                StatTableViewController.stats.append(0)
            }
            NSUserDefaults.standardUserDefaults().setObject(StatTableViewController.stats, forKey: "LicenseStats")
        }
        else {
            StatTableViewController.stats = stats!
        }
        let catStats = NSUserDefaults.standardUserDefaults().dictionaryForKey("LicenseCatStats") as? [String:[Int]]
        if catStats == nil {
            let arr = [0,0]
            for cat in QuestionConstants.categoryNames {
                StatTableViewController.categories[cat] = arr
            }
            NSUserDefaults.standardUserDefaults().setObject(StatTableViewController.categories, forKey: "LicenseCatStats")
        }
        else {
            StatTableViewController.categories = catStats!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? ExamViewController {
            if let identifier = segue.identifier {
                if identifier == "exam" {
                    destination.examMode = true
                    let simulator = Simulator(category: nil)
                    destination.simulator = simulator
                }
            }
        }
        
    }

}

