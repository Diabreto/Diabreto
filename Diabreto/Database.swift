//
//  User.swift
//  Diabreto
//
//  Created by João Bernardo on 18/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

class Database {
    var currentUser: User
    
    init() {
        self.currentUser = User(email: "manel@hotmail.com",
                                glycemiaUnit: "mg/dl",
                                carbohydratesUnit: "grams",
                                targetGlycemia: 120,
                                insulinProportion: 1.2,
                                correctionFactor: 1,
                                hyperGlycemiaThreshold: 180,
                                hypoGlycemiaThreshold: 60)
    }
}
