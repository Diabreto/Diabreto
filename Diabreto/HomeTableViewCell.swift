//
//  HomeTableViewCell.swift
//  Diabreto
//
//  Created by João Botelho on 18/02/17.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var glycemiaLabel: UILabel!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var mealInsulinLabel: UILabel!
    @IBOutlet weak var correctionInsulinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
