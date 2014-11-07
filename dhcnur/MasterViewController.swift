//
//  MasterViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/23.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController,UIPopoverPresentationControllerDelegate,HLJLDisplayContainer{

    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    var arr :NSArray = NSArray()
    var logonloc :NSString?
    var userid = ""
    var usergroup = ""
    var username = ""
    var EpisodeID:NSString?
    
    @IBAction func switclistview(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
           self.tableView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    func  dhc_currentDisplayedCode() -> NSString? {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loc = logonloc{
            configuview()
        }else{
           // showlogonview()
        }
    }
    override func viewWillAppear(animated: Bool) {
        //showlogonview()
    }
    func showlogonview(){
        var descon =  LogonViewController()
        //descon.data = userlogonlocs
        //descon.pVC = self
        //descon.modalPresentationStyle = .Popover
        
        //let popovercontroller = self.popoverPresentationController
        //popovercontroller?.sourceView = self.view
        //popovercontroller?.sourceRect = self.view.frame
        //popovercontroller?.permittedArrowDirections = .Any
        //popovercontroller?.delegate = self
        
        showViewController(descon, sender: nil)
    }

       func configuview(){
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
    /*
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        var sel = tableView.indexPathForSelectedRow()
        if let adm = EpisodeID{
               return true
        }
        return false
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let obj = arr[indexPath.row] as NSDictionary
        var ADM = obj["EpisodeID"]?.description
        let newTable = storyboard?.instantiateViewControllerWithIdentifier("EmrCodeTB") as PatCodeTableVC
        newTable.logonloc = logonloc
        newTable.EpisodeID = ADM
        newTable.uisplitvc = self.splitViewController?.viewControllers
        showViewController(newTable, sender: self)
    }
*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            var sel = tableView.indexPathForSelectedRow()
            if let indexPath = sel{
                let obj = arr[indexPath.row] as NSDictionary
                var ADM = obj["EpisodeID"]?.description
                var PatName = obj["PatName"]!.description

                var bedcode = obj["bedCode"]!.description

                
                 var dest = segue.destinationViewController as PatCodeTableVC
                dest.selectedpatname = PatName + "-" + bedcode
                dest.EpisodeID = ADM
                dest.logonloc = logonloc
                dest.uisplitvc = self.splitViewController!.viewControllers
                dest.PatName = PatName
                
//            let obj = arr[indexPath.section] as NSDictionary
//            let subobj = obj["subnod"] as NSArray
//            let sub = subobj[indexPath.row] as NSDictionary
//            let EmrCode = sub["EmrCode"]?.description
//            let EmrCodeName = sub["EmrCodenName"]?.description
//            var desttop = segue.destinationViewController as YBHLJLNavVC
//            //var desttop = dest.topViewController as DetailViewController
//            desttop.EmrCode = EmrCode
//            desttop.EmrCodeName = EmrCodeName
//            desttop.EpisodeID = EpisodeID
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

