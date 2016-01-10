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
        // Do any additional setup after loading the view, typically from a nib.
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
                }
            }
        }
        
    }

}

