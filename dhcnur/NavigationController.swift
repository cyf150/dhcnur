//
//  NavigationController.swift
//  dhcnur
//
//  Created by cyf on 14/11/4.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController ,HLJLDisplayContainer{

    override func viewDidLoad() {
        super.viewDidLoad()
        //configureTranitOverrideForSize(view.bounds.size)
        // Do any additional setup after loading the view.
    }
    func dhc_currentDisplayedCode() -> NSString?{
        if let tvc = topViewController as? HLJLDisplayContainer{
          return tvc.dhc_currentDisplayedCode()
        }
        return nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        //configureTranitOverrideForSize(size)
    }
    /*
    private func configureTranitOverrideForSize(size:CGSize){
        var traitOverride:UITraitCollection?
        if size.width < 414 {
            traitOverride = UITraitCollection(horizontalSizeClass: .Compact)
        }
        for vc in childViewControllers as [UIViewController]{
          setOverrideTraitCollection(traitOverride, forChildViewController: vc)
        }
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
