import Foundation

class Food {
    var name: String
    var carbs: Float
    var dosage: Int
    
    init(name: String, carbs: Float, dosage: Int = 1) {
        self.name = name
        self.carbs = carbs
        self.dosage = dosage
    }
}
