//
//  YBHLJLTableViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/29.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class YBHLJLTableViewController: UITableViewController {

    var EpisodeID:NSString?
    var EmrCode:NSString?
    var EmrCodeName:NSString?
    var arr:NSArray?
    @IBAction func close(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.title = EmrCodeName
        self.navigationItem.title = EmrCodeName
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: nil, action: Selector("close"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        getmenulist()
        self.tableView.registerNib(UINib(nibName: "HBCommView", bundle: nil)!, forCellReuseIdentifier: "HBCell")
        
    }
    func close(){
        //self.navigationController?.
    }
    
    func getmenulist()
    {
        var url = "http://10.56.32.87/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=NurEmr.Ipad.Common&methodName=getadmemrcodedata&type=Method"
        let param=["Adm":EpisodeID!,"EmrCode":EmrCode!]
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var num = 0
        if let tmpnum = arr?{
          num = tmpnum.count
        }
        
        return num
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("HBCell") as HBCommView
        if let arro = arr?
        {
           cell.dataobj = arro[indexPath.row] as? NSDictionary
        }
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
