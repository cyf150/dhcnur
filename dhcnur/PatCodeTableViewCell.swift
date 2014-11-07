//
//  PatCodeTableViewCell.swift
//  dhcnur
//
//  Created by cyf on 14/11/1.
//  Copyright (c) 2014年 cyf. All rights reserved.
//

import UIKit

class PatCodeTableViewCell: UITableViewCell {

         @IBOutlet weak var caredate: UILabel!
       @IBOutlet weak var CareTime: UILabel!
    @IBOutlet weak var CaseMeasure: UILabel!
    @IBOutlet weak var User: UILabel!
    
    var celldata:NSDictionary?{
        didSet{
            if let data = celldata{
                self.caredate.text = data["CareDate"]!.description
                self.CareTime.text = data["CareTime"]!.description
                self.CaseMeasure.text = data["CaseMeasure"]!.description
                self.User.text = data["User"]!.description
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
