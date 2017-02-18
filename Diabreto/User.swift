//
//  User.swift
//  Diabreto
//
//  Created by João Bernardo on 18/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import Alamofire
import SwiftyJSON

class User {
    var id: Int!
    var email: String!
    var authenticationToken: String!
    var glycemiaUnit: String!
    var carbohydratesToUnit: Int!
    var targetGlycemia: Int!
    var insulinToUnit: Float!
    var correctionFactor: Int!
    var hyperGlycemiaThreshold: Int!
    var hypoGlycemiaThreshold: Int!
    
    init() {
        self.id = -1
        self.email = nil
        self.authenticationToken = nil
        self.glycemiaUnit = nil
        self.carbohydratesToUnit = nil
        self.targetGlycemia = nil
        self.insulinToUnit = nil
        self.correctionFactor = nil
        self.hyperGlycemiaThreshold = nil
        self.hypoGlycemiaThreshold = nil
    }
    
    static func login(completion: @escaping (_ response: DataResponse<Any>) -> Void) {
        // TODO make login parameters dinamic from UI
        let params: Parameters = [
            "user": [
                "email": "manel@hotmail.com",
                "password": "manel123"
            ]
        ]
        
        Alamofire
        .request("http://www.pedrobelem.com/api/users/sign_in",
                 method: .post,
                 parameters: params,
                 encoding: JSONEncoding.default)
        .responseJSON { response in
            completion(response)
        }
    }
    
    func update(params: Parameters, completion: @escaping (_ response: DataResponse<Any>) -> Void) -> Void {
        let headers: HTTPHeaders = [
            "X-User-Email": self.email,
            "X-User-Token": self.authenticationToken
        ]
        
        Alamofire
        .request("http://www.pedrobelem.com/api/users/\(String(self.id))",
                 method: .put,
                 parameters: params,
                 encoding: JSONEncoding.default,
                 headers: headers)
        .responseJSON { response in
            completion(response)
        }
    }
    
    func localUpdate(attrs: JSON) {
        self.id = attrs["id"].int
        self.email = attrs["email"].string
        self.authenticationToken = attrs["authentication_token"].string
        self.glycemiaUnit = attrs["glycemia_unit"].string
        self.carbohydratesToUnit = attrs["carbohydrates_to_unit"].int
        self.targetGlycemia = attrs["target_glycemia"].int
        self.insulinToUnit = attrs["insulin_to_unit"].float
        self.correctionFactor = attrs["correction_factor"].int
        self.hyperGlycemiaThreshold = attrs["hyperglycemia_threshold"].int
        self.hypoGlycemiaThreshold = attrs["hypoglycemia_threshold"].int
    }
}
