//
//  PatsCollectionViewCell.swift
//  dhcnur
//
//  Created by cyf on 14/11/10.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class PatsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data:NSDictionary?{
        didSet{
          self.Name.text = data!["Patname"]?.description
        }
    }

}
