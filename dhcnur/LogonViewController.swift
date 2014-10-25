//
//  LogonViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/24.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class LogonViewController: UIViewController,UIPopoverControllerDelegate,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var selectloc: UIButton!
    var userlogonlocs:NSArray?
    var logonloc: NSString?
    var logonlocdesc:NSString?
    var logonuserid:NSString?
    var logongroup:NSString?
    var logonward:NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Selectlogonloc(sender: UIView) {
        if let loc = userlogonlocs? {
            //var descon = storyboard?.instantiateViewControllerWithIdentifier("SelectLocT") as UITableViewController
            var descon =  SelectLocTableViewController()
            descon.data = userlogonlocs
            descon.pVC = self
            descon.modalPresentationStyle = .Popover
            let popovercontroller = descon.popoverPresentationController
            popovercontroller?.sourceView = sender
            popovercontroller?.sourceRect = sender.bounds
            popovercontroller?.permittedArrowDirections = .Any
            popovercontroller?.delegate = self
            presentViewController(descon, animated: true, completion: nil)
        }
        else{
        
        }
    }

       //logon
    @IBAction func btnsure(sender: UIView) {
        if let loc = logonloc? {
           var descon = storyboard?.instantiateViewControllerWithIdentifier("spvc") as MyUISpitViewController  //MyUISpitViewController()
           var vc = descon.viewControllers
            //println(vc.count)
           //var master = descon.viewControllers[0].topViewController as MasterViewController
           descon.logonloc = loc
           showViewController(descon, sender: nil)
            //presentViewController(descon, animated: true, completion: nil)
        }
        else{
           logon()
        }
        
    }
    func logon() {
        var url = "http://10.56.32.189/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=Nur.Iphone.Common&methodName=logon&type=Method"
        var usern = username.text!
        var pass = password.text!
        var type = ""
        let params=["userName":usern,"password":pass,"logonLocType":type]
        HttpUtil().requestwithurlandparam(url, paramdic: params, CompletinonHander: {
            data in
            if let retdate = data as? NSObject {
                var strDIC = data as? NSDictionary
                println(strDIC)
                if strDIC?.count > 0 {
                   self.logonuserid = strDIC?["UserID"] as? NSString
                   self.userlogonlocs = strDIC?["Locs"] as? NSArray
                   if self.userlogonlocs?.count>0 {
                      var firstdic = self.userlogonlocs?[0] as NSDictionary
                      self.selectloc.titleLabel?.text = firstdic["LocDesc"] as NSString
                      self.logonloc = firstdic["LocID"] as? NSString
                      self.logongroup = firstdic["GroupID"] as? NSString
                      self.logonward = firstdic["WardID"] as? NSString
                }
                }
                //println(str)
                
            }
            else{
                println("error")
            }
        })
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "success"{
           if let loc = logonloc? {
              segue.perform()
            
            }
            else
            {
              logon()
            }
        }
        
        
    }
    

}
