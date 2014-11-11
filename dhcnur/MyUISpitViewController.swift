//
//  MyUISpitViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/23.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MyUISpitViewController: UISplitViewController,UISplitViewControllerDelegate,UIPopoverPresentationControllerDelegate {
    var logonloc:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loc = logonloc{
            if let sp = self.splitViewController{
              println(sp.collapsed)
            }
            self.delegate=self
            var ma = self.viewControllers[0] as? MasterTBarViewController
            if let mater = ma{
                mater.tblogonloc = self.logonloc
                //ma.tblogonloc = logonloc
                var firstabs = mater.viewControllers!
                //println(firstabs)
                //var firstab = firstabs[0].topViewController as? MasterViewController //MainViewController
                var firstab = firstabs[0].topViewController as? MainViewController
                if let master = firstab{
                    master.logonloc = logonloc
                }
            }
            
           
            presentsWithGesture = true
            preferredPrimaryColumnWidthFraction = 0.3
            preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
            //let navigationController = self.viewControllers[self.viewControllers.count-1] as UINavigationController
           // let navigationController = self.viewControllers[self.viewControllers.count-1] as NavigationController
           // navigationController.topViewController.navigationItem.leftBarButtonItem = self.displayModeButtonItem()

        }else{
         // configuview()
        }
              // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        println(displayMode)
        //let navigationController = self.viewControllers[self.viewControllers.count-1] as NavigationController
        //navigationController.topViewController.navigationItem.leftBarButtonItem = self.displayModeButtonItem()
    }
    private func configuview(){
        var descon =  LogonViewController()
        //descon.data = userlogonlocs
        //descon.pVC = self
        descon.modalPresentationStyle = .Popover
        var presingVC = self.viewControllers[0] as MasterTBarViewController
        var tbvc1 = presingVC.selectedViewController as MasterViewController
        let popovercontroller = tbvc1.popoverPresentationController
        popovercontroller?.sourceView = self.view
        popovercontroller?.sourceRect = self.view.frame
        popovercontroller?.permittedArrowDirections = .Any
        popovercontroller?.delegate = self
        
        presentViewController(descon, animated: true, completion: nil)

    }
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        if let nav = secondaryViewController as? NavigationController{
            if let secon = nav.topViewController as? DetailViewController{
                if let prima = primaryViewController as? HLJLDisplayContainer{
                   var ret = prima.pro_ifspmastervcneedpush!()
                    if let first = ret{
                        first.pushViewController(secon, animated: true)
                        return true
                    }
                }
            
            }
                /*
                if let mainvc = primaryViewController as? HLJLDisplayContainer{
                    var mainsel = mainvc.dhc_currentDisplayedCode()
                    if mainsel != nil{
                        if mainsel == tvc.dhc_currentDisplayedCode(){
                            var maintopvc = mainvc.dhc_mastercontrollertopVC!()
                            if  maintopvc != nil {
                                maintopvc?.pushViewController(secondaryViewController, animated: true)
                            }
                            
                            return true
                        }
                    }
                }
               */
            
        }
        
        return false
    }
    func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        
        if let vc = primaryViewController as? HLJLDisplayContainer{
            var primaryret = vc.pro_ifspmastervcneedseperate!()
            if let secondevc = primaryret {
                var nav = NavigationController()
                nav.pushViewController(secondevc, animated: true)
                return nav
            }
            /*
            if vc.dhc_currentDisplayedCode() != nil{
               var secondvc = vc.dhc_mastercontrollertopVC!()!.topViewController
                if let  sel = vc.dhc_masterselectvc!() as? NavigationController{
                   sel.popViewControllerAnimated(false)
                }
                var nav = NavigationController()
                nav.pushViewController(secondvc, animated: true)
                return nav            }
        }
        */
        }
        return nil
    }
    /*
    override func showDetailViewController(vc: UIViewController!, sender: AnyObject!) {
        println(vc)
        println(vc)
        var nav = vc as YBHLJLNavVC
        var top = nav.topViewController
        if let top1 = top?{
          var topnavi = top.navigationItem
          var topbut = topnavi.leftBarButtonItem
        }
        var disp = displayModeButtonItem()
        nav.leftbarbutton = displayModeButtonItem()
        var controls1 = self.viewControllers[0] as MasterTBarViewController
        //var arrobj  =
        if self.viewControllers.count == 1 {
          var sendobj = sender as PatCodeTableVC
            //sendobj.presentationController?.presentedViewController(nav)
            //sendobj.presentingViewController?.presentViewController(nav, animated: true, completion: nil)
            
            //self.viewControllers = [sendobj]
        }
        else{
            var arrobj = [controls1,nav]
            self.viewControllers = arrobj
        }
        

    }

    func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
               //showDetailViewController(vc, sender: nil)
        //nav.topViewController.navigationItem.leftBarButtonItem = self.displayModeButtonItem()
        return false
    }

   
    func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        var buttom = displayModeButtonItem()
        var model = displayMode
        //println(model)
        //println(buttom.description)
        //println(displayMode)
        return UISplitViewControllerDisplayMode.Automatic
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
