//
//  PatsCollectionViewCell.swift
//  dhcnur
//
//  Created by cyf on 14/11/10.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class PatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var DIAG: UILabel!
    @IBOutlet weak var Comm: UILabel!
    @IBOutlet weak var PatName: UILabel!
    @IBOutlet weak var bedcode: UILabel!
    @IBOutlet weak var image: UIImageView!
    var data:NSDictionary?{
        didSet{
            //var imagename = data!["image"] as NSString
            //self.image.image = UIImage(named: imagename)
            //self.image.setImage("http://10.56.32.87/dthealth/web/scripts/nurse/image/man.png", placeHolder: UIImage(named: imagename))
           
            self.PatName.text = data!["PatName"]?.description
            self.Comm.text = data!["Comm"]?.description
            self.DIAG.text = data!["DIAG"]?.description
        }
    }

}
