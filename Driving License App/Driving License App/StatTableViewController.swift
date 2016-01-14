//
//  StatTableViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 09/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class StatTableViewController: UITableViewController {
    
    // 0 - correct answers, 1 - total answers, 2 - passed exams, 3 - total exams
    static var stats = [Int]()
    
    /*
     * key - category name
     * value - array of correct and total answers
     */
    static var categories = [String:[Int]]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "General Stats:"
        }
        else {
            return "Category Answer Percentage:"
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        }
        else {
            return QuestionConstants.categoryNames.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stat", forIndexPath: indexPath)

        if indexPath.row == 0 && indexPath.section == 0 {
            cell.textLabel?.text = "Correct Answers"
            if StatTableViewController.stats[1] == 0 {
                cell.detailTextLabel?.text = "0%"
            }
            else {
                cell.detailTextLabel?.text = "\(Double(StatTableViewController.stats[0])/Double(StatTableViewController.stats[1])*100)%"
            }
        }
        else if indexPath.row == 1 && indexPath.section == 0{
            cell.textLabel?.text = "Passed Exams"
            if StatTableViewController.stats[3] == 0 {
                cell.detailTextLabel?.text = "0%"
            }
            else {
                cell.detailTextLabel?.text = "\(Double(StatTableViewController.stats[2])/Double(StatTableViewController.stats[3])*100)%"
            }
        }
        
        if indexPath.section == 1 {
            cell.textLabel?.text = "Category \(indexPath.row+1)"
            let categoryName = QuestionConstants.categoryNames[indexPath.row]
            if StatTableViewController.categories[categoryName]?[1] == 0 {
                cell.detailTextLabel?.text = "0%"
            }
            else {
                cell.detailTextLabel?.text = "\(Double((StatTableViewController.categories[categoryName]?[0])!)/Double((StatTableViewController.categories[categoryName]?[1])!)*100)%"
            }
        }

        return cell
    }

}
