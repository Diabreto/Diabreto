//
//  RecordTableViewCell.swift
//  
//
//  Created by Tiago Botelho on 18/02/2017.
//
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var Food: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
