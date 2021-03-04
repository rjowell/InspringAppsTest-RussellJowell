//
//  PageOccurenceCell.swift
//  InspriingAppsTest
//
//  Created by Russell Jowell on 3/3/21.
//

import UIKit

class PageOccurenceCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var pageOne: UILabel!
    @IBOutlet weak var pageTwo: UILabel!
    @IBOutlet weak var pageThree: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
