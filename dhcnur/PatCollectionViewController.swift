//
//  PatCollectionViewController.swift
//  dhcnur
//
//  Created by cyf on 14/11/8.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

let reuseIdentifier = "CollectCell"

class PatCollectionViewController: UIViewController{

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var CImage: UIImageView!
    @IBOutlet weak var bedcode: UILabel!
    var data:NSArray?
    var logonloc:NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let nib = UINib(nibName:"PatsCollectionViewCell",bundle:nil)
        image.image = UIImage(named: "BackgroundImage")
        //let flowLayout = CollectionViewLayout(
         //   traitCollection: traitCollection,size: UIScreen.mainScreen().bounds.size,rate: 1)
        //var par = self
        //var sp = par!.splitViewController
        //flowLayout.invalidateLayout()
        //collectionView.setCollectionViewLayout(flowLayout, animated: false)
        

        //collectionView.reloadData()
    
    }
    
    func collectionView(collectionView: UICollectionView!,
        didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        var dest = PatCodeTableVC()
            let selectdic = self.data![indexPath.row] as NSDictionary
            dest.selectedpatname = selectdic["PatName"]!.description! + "-" + selectdic["bedCode"]!.description!
            dest.EpisodeID = selectdic["EpisodeID"]?.description
            dest.logonloc = self.logonloc
            dest.PatName = selectdic["PatName"]?.description
            //showViewController(dest, sender: nil)
            showDetailViewController(dest, sender: nil)
            

    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var subn = 0
        if let patdata = self.data  {
           //let newarray = patdata as NSArray
           subn = patdata.count
        }
       return subn
        
    }

     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as PatCollectionViewCell
        if let dd = data{
          var indexdata = dd[indexPath.row] as NSDictionary
          cell.data = indexdata
        }
        //cell.data = ["Patname":indexPath.row,"bedcode":indexPath.row,"image":"flag_canada"]
        
        // Configure the cell
    
        return cell
    }

   

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
