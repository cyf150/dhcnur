//
//  SelectLocTableViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/25.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class SelectLocTableViewController: UITableViewController {

    var data:NSArray! = NSArray()
    var pVC:LogonViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("LocCell", forIndexPath: indexPath) as UITableViewCell
        var cell = tableView.dequeueReusableCellWithIdentifier("LocCell") as? UITableViewCell
        if let ce = cell {
            
        }
        else{
        cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "LocCell")
        }
        
         //let object = objects[indexPath.row] as NSDate
        let obj = data[indexPath.row] as! NSDictionary
        cell?.textLabel?.text = obj["LocDesc"]  as? String
        return cell!
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let obj = data[indexPath.row] as! NSDictionary
        var locid = obj["LocID"]?.description
        self.pVC?.logoninfo?.LogonLoc = locid
        self.pVC?.logoninfo?.UserGroup = obj["GroupID"] as? NSString
        self.pVC?.logoninfo?.LogonLocDesc = obj["LocDesc"] as? NSString
        self.pVC?.logoninfo?.Wardid = obj["WardID"] as? NSString
        self.pVC?.selectloc.titleLabel?.text = obj["LocDesc"] as? String

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
