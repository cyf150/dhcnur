//
//  MasterTBarViewController.swift
//  dhcnur
//
//  Created by cyf on 14/10/25.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MasterTBarViewController: UITabBarController  {
    var tblogonloc:NSString?
    var EpisodeID:NSString?
    var EmrCode:NSString?
    var EmrCodeName:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sp = self.splitViewController{
          var controls = sp.viewControllers
            var top:AnyObject = controls.last!
            println(controls.count)
        }
                // Do any additional setup after loading the view.
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
*/
    override func viewWillAppear(animated: Bool) {
        if let sp = self.splitViewController
        {
          println(self.splitViewController!.collapsed)
        }else{
          println("nullsplit")
        }
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
