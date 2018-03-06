//
//  TableViewCellForFirstView.swift
//  App for automation
//
//  Created by Chongzheng Zhang on 2/25/18.
//  Copyright © 2018 Chongzheng Zhang. All rights reserved.
//

import UIKit

class TableViewCellForFirstView: UITableViewCell {
    
 
    @IBOutlet var ImageView: UIImageView!
    
    @IBOutlet var LabelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
