//
//  LogonViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/24.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class LogonViewController: UIViewController,UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var sure: UIButton!
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
    
    @IBAction func username_didend(sender: AnyObject) {
        self.password.becomeFirstResponder()
    }
    
    
    @IBAction func password_didend(sender: AnyObject) {
        self.password.resignFirstResponder()
        if (password.text != "")&(username.text != "")
        {
           self.sure.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
    }
    
    @IBAction func View_TouchDown(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
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
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle{
      return UIModalPresentationStyle.None
    }
    
    func presentationController(controller:UIPresentationController!,viewControllerForAdaptivePresentationStyle style:UIModalPresentationStyle)->UIViewController!{
        let navVC = UINavigationController(rootViewController:controller.presentedViewController)
        return navVC
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let logon = logonloc{
          return true
        }
        else{
          return false
        }
    }
       //logon
    @IBAction func btnsure(sender: UIView) {
        if let loc = logonloc? {
           //var descon = storyboard?.instantiateViewControllerWithIdentifier("spvc") as MyUISpitViewController //TraitOverrideViewController  //MyUISpitViewController()
            //var descon = storyboard?.instantiateViewControllerWithIdentifier("TraitVC") as TraitOverrideViewController
             //descon.logonloc = logonloc
             //showViewController(descon, sender: nil)
            //presentViewController(descon, animated: true, completion: nil)
        }
        else{
           logon()
        }
        
    }
    func logon() {
        var url = "http://10.56.32.87/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=NurEmr.Ipad.Common&methodName=logon&type=Method"
        var usern = username.text!
        var pass = password.text!
        if (usern == "")||(pass == "")
        {
            let alert = UIAlertController(title: "", message: "用户名或密码不能为空！", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default) {
                [weak alert] action in
                alert!.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        var type = ""
        let params=["userName":usern,"password":pass,"logonLocType":type]
        HttpUtil().requestwithurlandparam(url, paramdic: params, CompletinonHander: {
            data in
            if let retdate = data as? NSObject {
                var strDIC = data as? NSDictionary
                //println(strDIC)
                if strDIC?.count > 0 {
                   self.logonuserid = strDIC?["UserID"] as? NSString
                    var errinfo = strDIC?["ErrorInfo"] as? NSString
                    if (errinfo? != ""){
                        let alerterr = UIAlertController(title: "", message: errinfo, preferredStyle: .Alert)
                        let okAction = UIAlertAction(title: "OK", style: .Default) {
                            [weak alerterr] action in
                            alerterr!.dismissViewControllerAnimated(true, completion: nil)
                            
                        }
                        alerterr.addAction(okAction)
                        self.presentViewController(alerterr, animated: true, completion: nil)
                        return
                    }
                   self.userlogonlocs = strDIC?["Locs"] as? NSArray
                   if self.userlogonlocs?.count>0 {
                      var firstdic = self.userlogonlocs?[0] as NSDictionary
                      self.selectloc.titleLabel?.text = firstdic["LocDesc"] as NSString
                      self.logonloc = firstdic["LocID"]?.description
                      self.logongroup = firstdic["GroupID"]?.description
                      self.logonward = firstdic["WardID"]?.description
                    }
                   
               }
                else{
                
                }
                //println(str)
                
            }
            else{
                //println("error")
                let alerterr = UIAlertController(title: "", message: "用户名或密码不能为空！", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default) {
                    [weak alerterr] action in
                    alerterr!.dismissViewControllerAnimated(true, completion: nil)
                }
                alerterr.addAction(okAction)
                self.presentViewController(alerterr, animated: true, completion: nil)

            }
        })
        
    }
    func clearlogon(){
      self.logonloc = nil
      self.userlogonlocs = nil
      //self.password.text = ""
      self.selectloc.titleLabel?.text = ""
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var des = segue.destinationViewController as TraitOverrideViewController
        //var mysp = des.childViewControllers[0] as MyUISpitViewController
        //mysp.logonloc = self.logonloc
        
        des.logonloc = self.logonloc
        des.logonobj = self
        
        
        
    }
    

}
