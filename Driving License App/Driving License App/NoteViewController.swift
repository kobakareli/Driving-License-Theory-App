//
//  NoteViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 13/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var explenation: UILabel!
    
    var questionExplenation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        explenation.numberOfLines = 0
        explenation.lineBreakMode = NSLineBreakMode.ByWordWrapping
        explenation.text = questionExplenation
    }

}
