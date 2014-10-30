//
//  YBHLJLNavVC.swift
//  dhcnur
//
//  Created by cyf on 14/10/29.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class YBHLJLNavVC: UINavigationController {

    var EpisodeID:NSString?
    var EmrCode:NSString?
    var EmrCodeName:NSString?
    var leftbarbutton:UIBarButtonItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = EmrCodeName?
        var tbVC = YBHLJLTableViewController()
        tbVC.EmrCode = EmrCode
        tbVC.EpisodeID = EpisodeID
        tbVC.EmrCodeName = EmrCodeName
        tbVC.leftbarbutton = leftbarbutton
        self.navigationItem.title = EmrCodeName
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: nil, action: Selector("close"))
        if let adm = EpisodeID?
        {
           self.pushViewController(tbVC, animated: true)
        }
        //self.topViewController.navigationItem.leftBarButtonItem =
        // Do any additional setup after loading the view.
    }
    func close(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
