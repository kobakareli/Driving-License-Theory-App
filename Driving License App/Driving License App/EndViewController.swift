//
//  EndViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 12/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var passed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if passed == true {
            label.text = "თქვენ წარმატებით გაიარეთ გამოცდა"
            self.view.backgroundColor = UIColor.greenColor()
        }
        else {
            label.text = "თქვენ ვერ ჩააბარეთ გამოცდა"
            self.view.backgroundColor = UIColor.redColor()
        }

    }
}
