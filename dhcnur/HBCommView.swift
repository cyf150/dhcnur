//
//  HBCommView.swift
//  dhcnur
//
//  Created by cyf on 14/10/29.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class HBCommView: UITableViewCell {

    @IBOutlet weak var CareDate: UILabel!
    
    @IBOutlet weak var CareTime: UILabel!
    
    @IBOutlet weak var CaseMeasure: UILabel!
    
    @IBOutlet weak var User: UILabel!
    
    var dataobj:NSDictionary? {
        didSet{
            if let data = dataobj{
                self.CareDate.text = data["CareDate"]?.description
                self.CareTime.text = data["CareTime"]?.description
                self.CaseMeasure.text = data["CaseMeasure"]?.description
                self.User.text = data["User"]?.description
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
