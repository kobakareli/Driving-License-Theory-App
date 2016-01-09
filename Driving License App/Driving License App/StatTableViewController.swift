//
//  StatTableViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 09/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class StatTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stat", forIndexPath: indexPath)

        cell.textLabel?.text = "stat"
        cell.detailTextLabel?.text = "value"

        return cell
    }

}
