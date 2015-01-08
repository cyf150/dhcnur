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
    var logoninfo : LogUser?
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
        if let loc = logoninfo? {
            //var descon = storyboard?.instantiateViewControllerWithIdentifier("SelectLocT") as UITableViewController
            var descon =  SelectLocTableViewController()
            descon.data = logoninfo?.LocArray
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
        if let logon = logoninfo{
          return true
        }
        else{
          return false
        }
    }
       //logon
    @IBAction func btnsure(sender: UIView) {
        if let loc = logoninfo? {
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
        var url = "http://10.56.32.254/dthealth/web/csp/dhc.nurse.pda.common.getdata.csp?className=NurEmr.Ipad.Common&methodName=logon&type=Method"
        var usern = username.text!
        var pass = password.text!
        if (usern == "")||(pass == "")
        {
            let alert = UtilAlert().CommAlert("用户名或密码不能为空！")
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
                   let loguser = strDIC?["UserID"]?.description
                    var errinfo = strDIC?["ErrorInfo"]?.description
                    if (errinfo? != ""){
                        let alert = UtilAlert().CommAlert(errinfo!)
                        self.presentViewController(alert, animated: true, completion: nil)
                        return
                    }
                   let locarr = strDIC?["Locs"] as? NSArray
                   if locarr?.count>0 {
                      var firstdic = locarr?[0] as NSDictionary
                      self.selectloc.titleLabel?.text = firstdic["LocDesc"] as NSString
                      if let obj = self.logoninfo{
                       
                    }else{
                        self.logoninfo = LogUser()
                    }
                      self.logoninfo?.UserName = self.username.text
                      self.logoninfo?.UserId = loguser
                      self.logoninfo?.Password = self.password.text
                      self.logoninfo?.LogonLoc = firstdic["LocID"]?.description
                      self.logoninfo?.LogonLocDesc = firstdic["LocDesc"]?.description
                      self.logoninfo?.UserGroup = firstdic["GroupID"]?.description
                      self.logoninfo?.Wardid = firstdic["WardID"]?.description
                      self.logoninfo?.UserGroupDesc = firstdic["GroupDesc"]?.description
                      self.logoninfo?.LocArray = locarr!
                    
                    }
                   
               }
                else{
                
                }
                //println(str)
                
            }
            else{
                let alert = UtilAlert().CommAlert("用户名或密码不能为空！")
                self.presentViewController(alert, animated: true, completion: nil)

            }
        })
        
    }
    func clearlogon(){
       self.logoninfo = nil
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
        
        des.logonloc = self.logoninfo?.LogonLoc
        des.logonobj = self
        
        
        
    }
    

}
