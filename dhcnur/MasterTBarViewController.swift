//
//  MasterTBarViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/25.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MasterTBarViewController: UITabBarController,HLJLDisplayContainer {
    var tblogonloc:NSString?
    var EpisodeID:NSString?
    var EmrCode:NSString?
    var EmrCodeName:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        println("MasterTBarViewDidLoad--")
        println(self.traitCollection.horizontalSizeClass.hashValue)
        if let sp = self.splitViewController{
          var controls = sp.viewControllers
            var top:AnyObject = controls.last!
            println(controls.count)
        }
                // Do any additional setup after loading the view.
    }
    func pro_topvcofspmastervcselectedvcisPatCodeTableVC() -> DetailViewController? {
        var ret:DetailViewController?
        if let selvc = self.selectedViewController as? HLJLDisplayContainer{
            if let nav = selvc as? NavigationController{
                if let top = nav.topViewController as? DetailViewController{
                   nav.popViewControllerAnimated(false)
                   ret = top
                }
            }
        }
        return ret
    }
    func pro_ifspmastervcneedseperate() -> DetailViewController? {
        var index = self.selectedIndex
        var seperateVC:DetailViewController?
        switch(index){
        case 0:
            var ret = self.pro_topvcofspmastervcselectedvcisPatCodeTableVC()
            seperateVC = ret
        default:
            seperateVC = nil
        }
        return seperateVC
    }
    func pro_ifspmastervcneedpush() -> NavigationController? {
        var index = self.selectedIndex
        var mastervc:NavigationController?
        switch(index){
        case 0:
            if let nav = self.selectedViewController as? NavigationController{
                if let top = nav.topViewController as? PatCodeTableVC{
                    mastervc = nav
                }
            }
        default:
            mastervc = nil
        }
        return mastervc

    }
    func  dhc_currentDisplayedCode() -> NSString? {
        if let selvc = self.selectedViewController as? HLJLDisplayContainer{
            
           return selvc.dhc_currentDisplayedCode()
            
        }
        return nil
    }
    func dhc_mastercontrollertopVC() -> NavigationController? {
        if let selvc = self.selectedViewController as? HLJLDisplayContainer{
            var main = self.selectedViewController as! NavigationController
            return main
        }
        return nil
    }
    func  dhc_masterselectvc() -> UIViewController? {
        return self.selectedViewController
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func showDetailViewController(vc: UIViewController, sender: AnyObject?) {
        var detail = self.viewControllers![0].topViewController as DetailViewController
        if let code = EmrCode{
           detail.EmrCode = EmrCode
            detail.EmrCodeName = EmrCodeName
           detail.EpisodeID = EpisodeID
           detail.showViewController(vc, sender: nil)
        }
        println(vc.description)
    }

    override func viewWillAppear(animated: Bool) {
        if let sp = self.splitViewController
        {
          println(self.splitViewController!.collapsed)
        }else{
          println("nullsplit")
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
