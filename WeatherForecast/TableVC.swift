//
//  TableVC.swift
//  WeatherForecast
//
//  Created by Samuel Gervais on 2016-09-16.
//  Copyright © 2016 Samuel Gervais. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    
    let reuseIdentifier:String = "cityCell"
    var arrayOfCities = ["Montreal" , "Trois-Rivieres" , " Quebec" , "Laval" , "Ottawa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfCities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)

        cell.textLabel?.text = arrayOfCities[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            self.arrayOfCities.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
