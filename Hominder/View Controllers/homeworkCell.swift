//
//  homeworkCell.swift
//  Hominder
//
//  Created by Apple on 09/09/19.
//  Copyright © 2019 Vasisht Muduganti. All rights reserved.
//

import UIKit
import SwipeCellKit
class homeworkCell: SwipeTableViewCell {
    
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
