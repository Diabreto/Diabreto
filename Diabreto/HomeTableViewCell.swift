//
//  HomeTableViewCell.swift
//  Diabreto
//
//  Created by João Botelho on 18/02/17.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var glucoseDisplay: UILabel!
    @IBOutlet weak var carbsDisplay: UILabel!
    @IBOutlet weak var InsMealDisplay: UILabel!
    @IBOutlet weak var CorrectionDisplay: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
