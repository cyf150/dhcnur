//
//  MasterViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/23.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    var arr :NSArray = NSArray()
    var logonloc :NSString?
    var userid = ""
    var usergroup = ""
    var username = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
       
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            var tbvc = split.viewControllers[0] as MasterTBarViewController
            self.logonloc = tbvc.tblogonloc
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        println("Masterviewinit")
        self.tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableViewAutomaticDimension
        if let loc = logonloc?{
            getmenulist()
        }
        
    }
    func getmenulist()
    {
        var url = "http://10.56.32.87/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=NurEmr.Ipad.Common&methodName=getcurwardpat&type=Method"
        let params=["wardId":logonloc!]
        HttpUtil().requestwithurlandparam(url, paramdic: params, CompletinonHander: {
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
   func getmenulist2()
   {
    let manager=AFHTTPRequestOperationManager()
    //var url = "http://api.openweathermap.org/data/2.5/weather"
    var url = "http://10.160.16.30/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=Nur.Iphone.Common&methodName=logon&type=Method"
    //var urlstr:NSString = "
    var set=NSSet()
    manager.responseSerializer.acceptableContentTypes=set.setByAddingObject("text/html")
    let params=["userName":"dh444444","password":"30","logonLocType":""]
    manager.GET(url,
        parameters: params,
        success: {
            (operation:AFHTTPRequestOperation!,
            responseObject:AnyObject!) in
            var strDIC = responseObject as? NSDictionary
            //println(str)
            if strDIC?.count>1 {
               self.arr = strDIC?["Locs"] as NSArray
                self.tableView.reloadData()
            }
            println("JSON:"+responseObject.description!)
        }, failure:{
            (operation:AFHTTPRequestOperation!,
            error:NSError!)in
            println("error:"+error.localizedDescription)
    } )
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "patemrcode" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                //let object = objects[indexPath.row] as NSDate
                let obj = arr[indexPath.row] as NSDictionary
                let controller = segue.destinationViewController  as PatCodeTableVC
                var adm = obj["EpisodeID"]?.description

                controller.EpisodeID = adm
                    controller.logonloc = logonloc
                //controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                //controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        //let object = objects[indexPath.row] as NSDate
        let obj = arr[indexPath.row] as NSDictionary
        cell.textLabel?.text = obj["PatName"] as NSString
        cell.detailTextLabel?.text = obj["bedCode"]?.description
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

