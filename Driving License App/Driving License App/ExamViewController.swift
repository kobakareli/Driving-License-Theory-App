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
    var simulator : Simulator? = nil
    var offset = 1
    
    var numberOfQuestions = 0 {
        didSet {
            questionNum.text = "\(questionsAnswered)/\(numberOfQuestions)"
        }
    }
    
    var image = UIImage(named: "road") {
        didSet {
            if let _ = image {
                offset = 2
            }
            else {
                offset = 1
            }
        }
    }
    
    var timeCount = 0 {
        didSet {
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
        }
    }
    
    var questionsAnswered = 0 {
        didSet {
            questionNum.text = "\(questionsAnswered)/\(numberOfQuestions)"
        }
    }
    
    var wrongAnswersNum = 0 {
        didSet {
            wrongAnswers.text = "\(wrongAnswersNum)"
        }
    }
    
    var question : Question?  = nil {
        didSet {
            if let q = question {
                let imageName = q.getImageName()
                image = UIImage(named: imageName)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var timer: UILabel!

    @IBOutlet weak var questionNum: UILabel!
    
    @IBOutlet weak var wrongAnswers: UILabel!
    
    func elapse() {
        timeCount -= 1
        if timeCount == 0 {
            myTimer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if examMode {
            timeCount = minutes*60
            myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("elapse"), userInfo: nil, repeats: true)
        }
        if let s = simulator {
            question = s.getNextQuestion()
            numberOfQuestions = s.getNumberOfQuestions()
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
        if let q = question {
            count += q.getAnswers().count
        }
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
        }
        if indexPath.row == offset-1 {
            if let cell = tableView.dequeueReusableCellWithIdentifier("question", forIndexPath: indexPath) as UITableViewCell? {
                cell.textLabel?.text = question?.getQuestion()
                cell.textLabel?.numberOfLines = 5
                cell.textLabel?.adjustsFontSizeToFitWidth = true
                c = cell
            }
        }
        if indexPath.row >= offset {
            if let cell = tableView.dequeueReusableCellWithIdentifier("answer", forIndexPath: indexPath) as UITableViewCell? {
                cell.textLabel?.text = question?.getAnswers()[indexPath.row-2]
                cell.textLabel?.numberOfLines = 5
                cell.textLabel?.adjustsFontSizeToFitWidth = true
                c = cell
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "next" && questionsAnswered < numberOfQuestions-1 {
            // get answer from the sender here, then generate new question
            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPathForCell(cell) {
                    if indexPath.row - offset == (question?.getCorrectAnswerIndex())! {
                        cell.textLabel?.backgroundColor = UIColor.greenColor()
                    }
                    else {
                        cell.textLabel?.backgroundColor = UIColor.redColor()
                        wrongAnswersNum += 1
                    }
                }
                question = simulator?.getNextQuestion()
                questionsAnswered += 1
                tableView.reloadData()
                return false
            }
        }
        return true
    }
}
