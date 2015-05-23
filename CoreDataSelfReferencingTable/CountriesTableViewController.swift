//
//  CountriesTableViewController.swift
//  CoreDataSelfReferencingTable
//
//  Created by Wesley Sadler on 5/22/15.
//  Copyright (c) 2015 Digital Sadler. All rights reserved.
//

import UIKit
import CoreData

class CountriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var error: NSError? = nil
        if (fetchedResultsController.performFetch(&error) == false) {
            NSLog("Unresolved error \(error), \(error!.userInfo)")
        }
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showStatesProvinces" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
                let countryLocation = object as! Location
                let locations = countryLocation.hasStateProvince as NSOrderedSet
                let controller = segue.destinationViewController as! StatesProvincesTableViewController
                controller.statesProvindes = locations
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CountryCell", forIndexPath: indexPath) as! UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        let location = object as! Location
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = location.name + " (" + location.code + ")"
    }
    
    // MARK: - Fetched results controller

    
    lazy var fetchedResultsController: NSFetchedResultsController = {
       
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext!

        
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "code IN %@", ["CAN","USA"])
        fetchRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        fetchedResultsController.delegate = self
        
//        var error: NSError? = nil
//        if !fetchedResultsController.performFetch(&error) {
//            NSLog("Unresolved error \(error), \(error!.userInfo)")
//        }
        return fetchedResultsController
        
        
    }()
        
    
}
