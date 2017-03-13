//
//  TableCell.swift
//  db
//
//  Created by Mitosis on 22/02/17.
//  Copyright © 2017 Mitosis. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
