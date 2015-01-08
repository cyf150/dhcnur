//
//  MasterViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/23.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController,UIPopoverPresentationControllerDelegate,HLJLDisplayContainer{

    @IBOutlet weak var segment: UISegmentedControl!
    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    var arr :NSArray = NSArray()
    var logonloc :NSString?
    var userid = ""
    var usergroup = ""
    var username = ""
    var EpisodeID:NSString?
    var backtableview:UITableView?
    
    @IBAction func segmentswitch(sender: UISegmentedControl) {
        var childvc = self.childViewControllers as NSArray
        var firstvc = self.tableView  //childvc[0] as? MasterViewController
        var sencondevc = childvc[0] as? PatCollectionViewController
        if sender.selectedSegmentIndex == 1{
            //hideContentController(firstvc)
            //tableView.removeFromSuperview()
            //self.view.addSubview(sencondevc!.view)
            //self.view.insertSubview(sencondevc!.view, aboveSubview: tableView)
            
            //self.view.inputView(sencondevc!.view as UIView)
            //backtableview = self.tableView
            self.tableView.hidden = true
            //self.view.insertSubview(sencondevc!.view, atIndex: 0)
            self.addChildViewController(sencondevc!)
           // tableView.removeFromSuperview()
        }else{
            //hideContentController(sencondevc!)
            //displayContentController(firstvc)
            self.tableView.hidden = false
            //sencondevc!.view.removeFromSuperview()
            //self.view.addSubview(backtableview!)
            //self.view.insertSubview(backtableview!, atIndex: 0)
        }

        
    }
    func displayContentController(content:UIViewController){
        //self.addChildViewController(content)
        self.view.addSubview(content.view)
        //content.view.frame = self
    }
    func hideContentController(content:UIViewController){
        //content.willMoveToParentViewController(self)
        content.view.removeFromSuperview()
        //content.removeFromParentViewController()
        
    }

    
    @IBAction func switclistview(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
           self.tableView.reloadData()
        }else{
           
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
        var par = self.parentViewController
        var sp = self.splitViewController
        if let mysp = sp{
            let mysplit = mysp as MyUISpitViewController
            logonloc = mysplit.logonloc
        }
        
        if let loc = logonloc{
            configuview()
        }else{
          
        }
    }
    override func viewWillAppear(animated: Bool) {
        
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
        var url = "http://10.56.32.254/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=NurEmr.Ipad.Common&methodName=getcurwardpat&type=Method"
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

