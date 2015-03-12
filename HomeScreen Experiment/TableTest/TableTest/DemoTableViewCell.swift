//
//  DemoTableViewCell.swift
//  TableTest
//
//  Created by viramesh on 3/11/15.
//  Copyright (c) 2015 vbits. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var mask: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
