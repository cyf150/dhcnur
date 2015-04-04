//
//  TraitOverrideViewController.swift
//  dhcnur
//
//  Created by cyf on 14/11/2.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class TraitOverrideViewController: UIViewController {
    var logonloc:NSString?
    var logonobj:LogonViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "showsp"{
            var descon = segue.destinationViewController as! MyUISpitViewController
            descon.logonloc = logonloc
        //
        //}
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        var traitOverride: UITraitCollection? = nil
        if size.width > 414 {
            traitOverride = UITraitCollection(horizontalSizeClass: .Regular)
            setOverrideTraitCollection(traitOverride, forChildViewController: childViewControllers[0] as! UIViewController)
        }
        else{
            traitOverride = UITraitCollection(horizontalSizeClass: .Compact)
            setOverrideTraitCollection(nil, forChildViewController: childViewControllers[0] as! UIViewController)
        }
       
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
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
