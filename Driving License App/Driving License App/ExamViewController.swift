//
//  ExamViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 08/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
    
    var myTimer = NSTimer()
    var minutes = 30
    var timeCount = 0
    
    @IBOutlet weak var timer: UILabel!

    func elapse() {
        timeCount -= 1
        var text = ""
        if timeCount/60 < 10 {
            text = "0\(timeCount/60)"
        }
        else {
            text = "\(timeCount/60)"
        }
        if timeCount%60 < 10 {
            text = text + ":0\(timeCount%60)"
        }
        else {
            text = text + ":\(timeCount%60)"
        }
        timer.text = text
        if timeCount == 0 {
            myTimer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeCount = minutes*60
        timer.text = "\(minutes):00"
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("elapse"), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
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
