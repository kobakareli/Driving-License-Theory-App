//
//  ExamViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 08/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
    
    var examMode = false
    var myTimer = NSTimer()
    var minutes = 30
    var timeCount = 0
    var image = UIImage(named: "road")
    var simulator : Simulator? = nil
    
    var question : Question?  = nil {
        didSet {
            image = UIImage(named: question!.getImageName())
        }
    }
    
    @IBOutlet weak var timer: UILabel!

    @IBOutlet weak var questionNum: UILabel!
    
    @IBOutlet weak var wrongAnswers: UILabel!
    
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
        if examMode {
            timeCount = minutes*60
            timer.text = "\(minutes):00"
            myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("elapse"), userInfo: nil, repeats: true)
        }
        if let s = simulator {
            question = s.getNextQuestion()
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count = 1
        if let _ = image {
            count += 1
        }
        count += (question?.getAnswers().count)!
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let _ = image {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCellWithIdentifier("image", forIndexPath: indexPath) as UITableViewCell? {
                    cell.imageView?.image = image
                    c = cell
                }
            }
            if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCellWithIdentifier("question", forIndexPath: indexPath) as UITableViewCell? {
                    cell.textLabel?.text = question?.getQuestion()
                    c = cell
                }
                
            }
            if indexPath.row > 1 {
                if let cell = tableView.dequeueReusableCellWithIdentifier("answer", forIndexPath: indexPath) as UITableViewCell? {
                    cell.textLabel?.text = question?.getAnswers()[indexPath.row-2]
                    c = cell
                }
            }
        }
        else {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCellWithIdentifier("question", forIndexPath: indexPath) as UITableViewCell? {
                    cell.textLabel?.text = question?.getQuestion()
                    c = cell
                }
                
            }
            if indexPath.row > 0 {
                if let cell = tableView.dequeueReusableCellWithIdentifier("answer", forIndexPath: indexPath) as UITableViewCell? {
                    cell.textLabel?.text = question?.getAnswers()[indexPath.row-1]
                    c = cell
                }
            }
        }
        return c
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if let _ = image {
                return image!.size.height*(UIScreen.mainScreen().bounds.width-22)/image!.size.width
            }
        }
        return UITableViewAutomaticDimension
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "image" {
                if let destination = segue.destinationViewController as? ImageViewController {
                    if let cell = sender as? UITableViewCell {
                        destination.image = cell.imageView?.image
                    }
                }
            }
        }
    }
}
