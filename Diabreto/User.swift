//
//  User.swift
//  Diabreto
//
//  Created by João Bernardo on 18/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import Alamofire

class User {
    var email: String?
    var glycemiaUnit: String?
    var carbohydratesUnit: String?
    var targetGlycemia: Int?
    var insulinProportion: Float?
    var correctionFactor: Int?
    var hyperGlycemiaThreshold: Int?
    var hypoGlycemiaThreshold: Int?
    
    init(email: String, glycemiaUnit: String, carbohydratesUnit: String, targetGlycemia: Int, insulinProportion: Float, correctionFactor: Int, hyperGlycemiaThreshold: Int, hypoGlycemiaThreshold: Int) {
        self.email = email
        self.glycemiaUnit = glycemiaUnit
        self.carbohydratesUnit = carbohydratesUnit
        self.targetGlycemia = targetGlycemia
        self.insulinProportion = insulinProportion
        self.correctionFactor = correctionFactor
        self.hyperGlycemiaThreshold = hyperGlycemiaThreshold
        self.hypoGlycemiaThreshold = hypoGlycemiaThreshold
    }
    
    func update(attrs: Parameters, completion: @escaping (_ response: Alamofire.DataResponse<Any>) -> Void) -> Void {
        Alamofire
        .request("http://localhost:3000/users",
                 method: .put,
                 parameters: ["user": attrs],
                 encoding: JSONEncoding.default)
        .responseJSON { (response) -> Void in
            completion(response)
        }
    }
}
