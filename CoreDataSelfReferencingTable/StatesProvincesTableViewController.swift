//
//  StatesProvincesTableViewController.swift
//  CoreDataSelfReferencingTable
//
//  Created by Wesley Sadler on 5/22/15.
//  Copyright (c) 2015 Digital Sadler. All rights reserved.
//

import UIKit

class StatesProvincesTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var statesProvindes: NSOrderedSet? = nil
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myCount = self.statesProvindes?.count {
            return myCount
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StatesProvincesCell", forIndexPath: indexPath) as! UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let location = self.statesProvindes![indexPath.row] as! Location
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = location.name + " (" + location.code + ")"
    }
    
}
