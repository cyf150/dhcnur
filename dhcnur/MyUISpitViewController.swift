//
//  MyUISpitViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/23.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MyUISpitViewController: UISplitViewController,UISplitViewControllerDelegate {
    var logonloc:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
        var ma = self.viewControllers[0] as MasterTBarViewController
        ma.tblogonloc = logonloc
        presentsWithGesture = true
        preferredPrimaryColumnWidthFraction = 0.3
        preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        //let navigationController = self.viewControllers[self.viewControllers.count-1] as UINavigationController
        let navigationController = self.viewControllers[self.viewControllers.count-1] as YBHLJLNavVC
        navigationController.topViewController.navigationItem.leftBarButtonItem = self.displayModeButtonItem()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        println(displayMode)
        let navigationController = self.viewControllers[self.viewControllers.count-1] as YBHLJLNavVC
        navigationController.topViewController.navigationItem.leftBarButtonItem = self.displayModeButtonItem()
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
*/
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
