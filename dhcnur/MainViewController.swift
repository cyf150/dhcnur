//
//  MainViewController.swift
//  dhcnur
//
//  Created by cyf on 14/11/8.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var CollectView: UIView!
    @IBOutlet weak var ListView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    var logonloc:NSString?
    var backcollectvc:PatCollectionViewController?
    var backtablevc:MasterViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectvc = storyboard?.instantiateViewControllerWithIdentifier("PatCollectView") as PatCollectionViewController
        var childvc = self.childViewControllers as NSArray
        var mavc1 = childvc[1] as MasterViewController
        //var colvc = childvc[0] as PatCollectionViewController
        mavc1.logonloc = logonloc
        mavc1.configuview()
       // displayContentController(collectvc)
        //CollectView.hidden = true
        // Do any additional setup after loading the view.
    }
  
    @IBAction func segmentselected(sender: UISegmentedControl) {
        var childvc = self.childViewControllers as NSArray
        //var firstvc = childvc[1] as? MasterViewController
        //var plistvc = MasterViewController()
        //plistvc.logonloc = self.logonloc
        
        //var collectvc = PatCollectionViewController()
        //displayContentController(collectvc)
        //var mavc = childvc[1] as MasterViewController
        //ar colvc = childvc[0] as PatCollectionViewController
        if sender.selectedSegmentIndex == 1{
            //var mavc = childvc[1] as MasterViewController
            ///var colvc = childvc[0] as PatCollectionViewController
            //self.view.bringSubviewToFront(colvc.view)
            self.view.exchangeSubviewAtIndex(0, withSubviewAtIndex: 1)
            
            
            //mavc.view.alpha = CGFloat(0.0)
            //colvc.view.alpha = CGFloat(1.0)
            //backtablevc = mavc
            //mavc.removeFromParentViewController()
            //self.addChildViewController(backcollectvc!)
            //self.view.addSubview(backcollectvc!.view)
        
        }else{
            self.view.exchangeSubviewAtIndex(0, withSubviewAtIndex: 1)
          //hideContentController(plistvc!)
            //var mavc = childvc[1] as MasterViewController
            //ar colvc = childvc[0] as PatCollectionViewController
            //colvc.view.alpha = CGFloat(0.0)
            //mavc.view.alpha = CGFloat(1.0)
            /*
            var mastervc:MasterViewController!
            if let backtb = backtablevc{
               mastervc = backtb
            }else{
               let mastervc2 = storyboard?.instantiateViewControllerWithIdentifier("MasterVC") as MasterViewController
               mastervc2.logonloc = self.logonloc
                mastervc = mastervc2
            }
             //var mast = childvc[0] as MasterViewController
            var root1 = self.childViewControllers as NSArray
            backcollectvc = colvc
            colvc.removeFromParentViewController()
            var root2 = self.childViewControllers as NSArray
             //colvc.removeFromParentViewController()
            //colvc.view.alpha = CGFloat(0.0)
            self.addChildViewController(mastervc)
            self.view.addSubview(mastervc.view)
            //displayContentController(mastervc)
            //self.view.bringSubviewToFront(mastervc.view)
            //displayContentController(collectvc)
*/
          
        }
        
    }
    func displayContentController(content:UIViewController){
        //self.addChildViewController(content)
        self.view.addSubview(content.view)
        //content.view.frame = self
    }
    func hideContentController(content:UIViewController){
        //content.willMoveToParentViewController(self)
        content.view.removeFromSuperview()
        //content.removeFromParentViewController()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        var selectindex = segment.selectedSegmentIndex
        var ifselect = segment.selected
        if let ident = identifier{
            if (segment.selectedSegmentIndex == 0)&&(ident == "showlist"){
               return true
            }else{
               return false
            }
        }else{
            return false
        }
        
    }
*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showlist"{
           var dest = segue.destinationViewController as MasterViewController
           dest.logonloc = logonloc
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
