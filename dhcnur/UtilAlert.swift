//
//  UtilAlert.swift
//  dhcnur
//
//  Created by cyf on 14/11/7.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import Foundation

class UtilAlert:UIAlertController{
    func CommAlert(desc:String)->UIAlertController{
        let alert = UIAlertController(title: "", message: desc, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            [weak alert] action in
            alert!.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(okAction)
        return alert
    }
}
