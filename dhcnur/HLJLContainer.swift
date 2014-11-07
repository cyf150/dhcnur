//
//  HLJLContainer.swift
//  dhcnur
//
//  Created by cyf on 14/11/4.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

@objc protocol HLJLDisplayContainer {
    func dhc_currentDisplayedCode()-> NSString?
    optional func dhc_mastercontrollertopVC() -> NavigationController?
    optional func dhc_masterselectvc() -> UIViewController?
    //MARK Splitviewcontroller主vc选中选项卡是否需要拆分
    optional func pro_ifspmastervcneedseperate()->DetailViewController?
    //MARK Splitviewcontroller主vc选中选项卡是否需要push新viewcontroller
    optional func pro_ifspmastervcneedpush()->NavigationController?
    //MARK Splitviewcontroller主vc选中选项卡topvc是否是PatCodeTableVC
    optional func pro_topvcofspmastervcselectedvcisPatCodeTableVC()->DetailViewController?
}

