//
//  RecordTableViewCell.swift
//  
//
//  Created by Tiago Botelho on 18/02/2017.
//
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var Carbs: UILabel!
    @IBOutlet weak var Food: UILabel!
    @IBOutlet weak var Dosage: UITextField!
    
    var viewController: RecordViewController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onChangeDosage(_ sender: UITextField) {
        var carbs: Float = 0.0
        self.viewController.selectedFood.filter {
            $0.name.lowercased() == self.Food.text?.lowercased()
        }.first?.dosage = Int(sender.text!)!
        
        for food:Food in self.viewController.selectedFood {
            carbs += (food.carbs * Float(food.dosage))/100.0
        }
        
        self.viewController.carbsTextField!.text! = String(carbs)
        self.viewController.mealInsulinTextField?.text = String(carbs/self.viewController.currentUser.insulinToUnit)
        self.viewController.updateTotalFieldVal()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
