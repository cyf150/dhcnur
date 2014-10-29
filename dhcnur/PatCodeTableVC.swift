//
//  PatCodeTableVC.swift
//  dhcnur
//
//  Created by cyf on 14/10/28.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class PatCodeTableVC: UITableViewController {

    var EpisodeID :NSString?
    var logonloc :NSString?
    var arr :NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getmenulist()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func getmenulist()
    {
     var url = "http://10.56.32.87/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=NurEmr.Ipad.Common&methodName=getemrcode&type=Method"
        let param=["Adm":EpisodeID!,"Loc":logonloc!]
        HttpUtil().requestwithurlandparam(url, paramdic: param, CompletinonHander: {
                 data in
                 if let retdate = data as? NSObject {
                    var strDIC = data as? NSArray
                    self.arr = strDIC!
                    self.tableView.reloadData()
                    println(retdate)
                }
                else{
                   println("error")
                }
           })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        var num = 0
        if let nu = arr?{
          num = nu.count
        }
        return num
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var num = 0
        if let nu = arr?{
            var obj = arr![section] as NSDictionary
            var subnodobj = obj["subnod"] as NSArray
            num = subnodobj.count
        }
        
        return num
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if let ti = arr?{
            var obj = arr![section] as NSDictionary
            title = obj["NodName"] as NSString
        }
       
        return title
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("SubCell", forIndexPath: indexPath) as UITableViewCell
        //let object = objects[indexPath.row] as NSDate
        let obj = arr![indexPath.section] as NSDictionary
        let subobj = obj["subnod"] as NSArray
        let sub = subobj[indexPath.row] as NSDictionary
        cell.textLabel?.text = sub["EmrCodeName"]?.description
        cell.detailTextLabel?.text = sub["IfSaved"]?.description
        cell.accessoryType = UITableViewCellAccessoryType.None
        return cell
        
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
