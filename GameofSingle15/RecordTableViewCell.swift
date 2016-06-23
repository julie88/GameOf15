//
//  RecordTableViewCell.swift
//  GameofSingle15
//
//  Created by Koichi Okada on 6/12/16.
//  Copyright © 2016 GregSimons. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet var iMove: UILabel!
    @IBOutlet var iTime: UILabel!
    @IBOutlet var iRanking: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
