//
//  CollectionViewLayout.swift
//  dhcnur
//
//  Created by cyf on 14/11/11.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class CollectionViewLayout: UICollectionViewFlowLayout {
    
    init(traitCollection: UITraitCollection,size: CGSize,rate: CGFloat) {
        super.init()
        scrollDirection = .Vertical
        minimumInteritemSpacing = 1.0;
        minimumLineSpacing = 1.0;
        headerReferenceSize = CGSizeZero;
        footerReferenceSize = CGSizeZero;
        var colnum:CGFloat = 3
        var sectionw:CGFloat = 2.0
        var toph:CGFloat = 5
        var bottomh:CGFloat = 5
        var w = (size.width*rate - colnum*2.0*sectionw)/colnum
        var h:CGFloat = 100
        
        if traitCollection.userInterfaceIdiom == .Pad {
            itemSize = CGSize(width:w , height: h)
            sectionInset = UIEdgeInsets(top: toph, left: sectionw,
                bottom: bottomh, right: sectionw)
        } else {
            itemSize = CGSize(width:w , height: h)
            sectionInset = UIEdgeInsets(top: toph, left: sectionw,
                bottom: bottomh, right: sectionw)
        }
        itemSize.height = UITableViewAutomaticDimension
        
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

}
