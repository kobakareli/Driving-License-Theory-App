//
//  TheoryViewController.swift
//  Driving License App
//
//  Created by Tornike Mandzulashvili on 1/9/16.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class TheoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(false, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? TheoryPdfViewController {
            if let identifier = segue.identifier {
                destination.fileName = identifier
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
