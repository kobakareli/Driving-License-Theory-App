//
//  CategoryTableViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 08/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    let categoryNames : [String] = [
    "მძღოლის, მგზავრის და ქვეითის მოვალეობა, საცნობი ნიშნები, კონვენცია",
    "უწესივრობა და პირობები, რომელთა დროს აკრძალულია სატრანსპორტო საშუალების ექსპლუატაცია",
    "მაფრთხილებელი ნიშნები",
    "პრიორიტეტის ნიშნები"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath)
        let rowId : NSInteger = indexPath.row
        cell.textLabel?.text = categoryNames[rowId]
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "აირჩიეთ კატეგორია"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "free" {
                if let destination = segue.destinationViewController as? ExamViewController {
                    if let cell = sender as? UITableViewCell {
                        if let label = cell.textLabel {
                            let category = label.text
                            let simulator = Simulator(category: category)
                            destination.examMode = false
                            destination.simulator = simulator
                        }
                    }
                }
            }
        }
    }

}
