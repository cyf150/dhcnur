//
//  YBHLJLTableViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/29.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController ,HLJLDisplayContainer{

   
    var EpisodeID:NSString?
    var EmrCode:NSString?
    var EmrCodeName:NSString?
    var arr:NSArray?
    var leftbarbutton:UIBarButtonItem?
    var PatName:NSString?
   
    @IBAction func close(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func dhc_currentDisplayedCode()-> NSString?{
       return EmrCode
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        let nib = UINib(nibName:"PatCodeTableViewCell",bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"YBCell")
        println("viewdidload:")
       
        configureView()
        //self.tableView.reloadData()
        
    }
    private func configureView(){
        self.navigationItem.title = EmrCodeName as! String
        if let adm = EmrCode{
            makeAllContentHidden(false)
            if let btn = leftbarbutton{
                self.navigationItem.leftBarButtonItem = leftbarbutton
            }
            if let adm = EpisodeID
            {
                getmenulist()
            }
           
        }
        else{
            
            if let empty = storyboard?.instantiateViewControllerWithIdentifier("NoSelectView") as? UIViewController {
                showViewController(empty, sender: self)
            }
            makeAllContentHidden(true)
        }
        

   }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //println(self.splitViewController)
        if let svc = splitViewController {
            if !svc.collapsed {
                navigationItem.setLeftBarButtonItem(svc.displayModeButtonItem(), animated: true)
                navigationItem.leftItemsSupplementBackButton = true
                navigationItem.hidesBackButton = false
            }
        }
    }
    // Private methods
    private func makeAllContentHidden(hidden: Bool) {
        for subview in view.subviews as! [UIView] {
            subview.hidden = hidden
        }
        if hidden {
            title = ""
        }
    }
    func close(){
        //self.navigationController?.
    }
    
    func getmenulist()
    {
        var url = "http://123.56.91.132/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=NurEmr.Ipad.Common&methodName=getadmemrcodedata&type=Method"
        let param=["Adm":EpisodeID!,"EmrCode":EmrCode!]
        HttpUtil().requestwithurlandparam(url, paramdic: param, CompletinonHander: {
            data in
            if let retdate = data as? NSObject {
                var strDIC = data as? NSArray
                if let dd = strDIC{
                    self.arr = strDIC!
                    self.tableView.reloadData()
                    //self.tableView.reloadData()
                    //println(retdate)
                }
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var num = 0
        if let tmpnum = arr{
          num = tmpnum.count
        }
        
        return num
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! PatCodeTableVC
        // dest.uisplitvc = self.splitViewController! as MyUISpitViewController
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        //let cell = tableView.dequeueReusableCellWithIdentifier("HBCell") as HBCommView
        let cell =  tableView.dequeueReusableCellWithIdentifier("YBCell", forIndexPath: indexPath) as? PatCodeTableViewCell
        if let arro = arr
        {
           cell!.celldata = arro[indexPath.row] as? NSDictionary
        }
        return cell!
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
