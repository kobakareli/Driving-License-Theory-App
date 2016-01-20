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
    var defaultColor = UIColor()
    private var answerSelected = false
    private var selectedCell = UITableViewCell()
    private var correctCell: UITableViewCell? = nil
    private var questionIndexPath: NSIndexPath?
    
    var numberOfQuestions = 0 {
        didSet {
            questionNum.text = "\(questionsAnswered)/\(numberOfQuestions)"
        }
    }
    
    var image: UIImage? = nil {
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
                if let imgName = imageName {
                    image = UIImage(named: imgName)
                } else {
                    image = nil
                }
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
            performSegueWithIdentifier("end", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        if examMode {
            timeCount = minutes*60
            myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("elapse"), userInfo: nil, repeats: true)
        }
        if let s = simulator {
            question = s.getNextQuestion()
            numberOfQuestions = s.getNumberOfQuestions()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if answerSelected {
            selectedCell.contentView.backgroundColor = UIColor.redColor()
            if let _ = correctCell {
                correctCell!.contentView.backgroundColor = UIColor.greenColor()
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count = 0
        if let _ = image {
            count += 1
        }
        if let q = question {
            count += (q.getAnswers().count+1)
        }
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let _ = image {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCellWithIdentifier("image", forIndexPath: indexPath) as UITableViewCell? {
                    let imageView = UIImageView(frame: CGRectMake(0,0, cell.frame.width, cell.frame.height))
                    imageView.image = image
                    cell.backgroundView = UIView();
                    cell.backgroundView?.addSubview(imageView)
                    cell.backgroundColor = cell.contentView.backgroundColor
                    c = cell
                }
            }
        }
        if indexPath.row == offset-1 {
            if let cell = tableView.dequeueReusableCellWithIdentifier("question", forIndexPath: indexPath) as UITableViewCell? {
                questionIndexPath = indexPath
                cell.backgroundColor = cell.contentView.backgroundColor
                if let color = cell.textLabel?.backgroundColor {
                    defaultColor = color
                }
                cell.textLabel?.text = question?.getQuestion()
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
                c = cell
            }
        }
        if indexPath.row >= offset {
            if let cell = tableView.dequeueReusableCellWithIdentifier("answer", forIndexPath: indexPath) as UITableViewCell? {
                cell.backgroundColor = cell.contentView.backgroundColor
                cell.textLabel?.text = question?.getAnswers()[indexPath.row-offset]
                cell.contentView.backgroundColor = defaultColor
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
                if let q = question {
                    if (indexPath.row - offset+1) == q.getCorrectAnswerIndex() {
                        correctCell = cell
                        if answerSelected == true {
                            cell.contentView.backgroundColor = UIColor.greenColor()
                        }
                    }
                    
                }
                if answerSelected && cell == selectedCell {
                    cell.contentView.backgroundColor = UIColor.redColor()
                }
                c = cell
            }
        }
        return c
    }
    
    func tableView(tableView : UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if answerSelected {
            selectedCell.contentView.backgroundColor = UIColor.redColor()
        }
        if offset == 2 && indexPath.row == 0 && questionIndexPath != nil {
            tableView.selectRowAtIndexPath(questionIndexPath, animated: false, scrollPosition: .None)
        }
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if let _ = image {
                return image!.size.height*(UIScreen.mainScreen().bounds.width)/image!.size.width
            }
        }
        return UITableViewAutomaticDimension
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "image" {
                if let destination = segue.destinationViewController as? ImageViewController {
                    if let cell = sender as? UITableViewCell {
                        if let imageView = cell.backgroundView?.subviews[0] as? UIImageView {
                            destination.image = imageView.image
                        }
                    }
                }
            }
            if identifier == "end" {
                if let destination = segue.destinationViewController as? EndViewController {
                    if wrongAnswersNum <= 3 && questionsAnswered == numberOfQuestions {
                        if examMode == true {
                            StatTableViewController.stats[2] += 1
                            StatTableViewController.stats[3] += 1
                        }
                        destination.passed = true
                    }
                    else {
                        if examMode == true {
                            StatTableViewController.stats[3] += 1
                        }
                        destination.passed = false
                    }
                    destination.examMode = examMode
                    NSUserDefaults.standardUserDefaults().setObject(StatTableViewController.stats, forKey: "LicenseStats")
                    NSUserDefaults.standardUserDefaults().setObject(StatTableViewController.categories, forKey: "LicenseCatStats")
                }
            }
            if identifier == "note" {
                if let destination = segue.destinationViewController as? NoteViewController {
                    if let q = question {
                        destination.questionExplenation = q.getExplanation()
                    }
                }
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "end" && questionsAnswered < numberOfQuestions {
            if answerSelected == true {
                if wrongAnswersNum > 3 && examMode == true {
                    return true
                }
                if SettingsViewController.settings[0] == true {
                    if let _ = correctCell {
                        correctCell!.contentView.backgroundColor = defaultColor
                    }
                }
                answerSelected = false
                selectedCell = UITableViewCell()
                correctCell = nil
                question = simulator?.getNextQuestion()
                tableView.reloadData()
            }
            return false
        }
        if identifier == "next" {
            if answerSelected == false {
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(cell) {
                        if indexPath.row - offset == (question?.getCorrectAnswerIndex())!-1 {
                            correctCell = cell
                            cell.contentView.backgroundColor = UIColor.greenColor()
                            StatTableViewController.stats[0] += 1
                            StatTableViewController.categories[(question?.getCategory())!]?[0] += 1
                        }
                        else {
                            selectedCell = cell
                            cell.contentView.backgroundColor = UIColor.redColor()
                            if SettingsViewController.settings[0] == true {
                                if let _ = correctCell {
                                    if let ip = tableView.indexPathForCell(correctCell!) {
 -                                        if ip.row - offset+1 == question!.getCorrectAnswerIndex() {
 -                                            correctCell!.contentView.backgroundColor = UIColor.greenColor()
 -                                        }
                                    }
                                }
                            }
                            wrongAnswersNum += 1
                        }
                    }
                    StatTableViewController.stats[1] += 1
                    StatTableViewController.categories[(question?.getCategory())!]?[1] += 1
                    questionsAnswered += 1
                    answerSelected = true
                }
            }
            return false
        }
        if identifier == "note" {
            return answerSelected
        }
        return true
    }
}
