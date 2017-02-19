//
//  User.swift
//  Diabreto
//
//  Created by João Bernardo on 18/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class Record {
    var id: Int!
    var dateTime: String!
    var glycemia: Int!
    var carbohydrates: Int!
    var mealInsulin: Float!
    var correctionInsulin: Float!
    var activity: Float!
    var notes: String!
    
    init() {
        self.id = -1
        self.dateTime = nil
        self.glycemia = nil
        self.carbohydrates = nil
        self.mealInsulin = nil
        self.correctionInsulin = nil
        self.activity = nil
        self.notes = nil
    }
    
    
    init(dateTime: String, glycemia: Int, carbohydrates: Int, mealInsulin: Float, correctionInsulin: Float, activity: Float) {
        self.id = -1
        self.dateTime = dateTime
        self.glycemia = glycemia
        self.carbohydrates = carbohydrates
        self.mealInsulin = mealInsulin
        self.correctionInsulin = correctionInsulin
        self.activity = activity
        self.notes = nil
    }
    
    static func getRecords() {
        let headers: HTTPHeaders = [
            "X-User-Email": AppDelegate.database.currentUser.email,
            "X-User-Token": AppDelegate.database.currentUser.authenticationToken
        ]
        
        let response: DataResponse<Any> = Alamofire
            .request("http://www.pedrobelem.com/api/records",
                     method: .get,
                     parameters: nil,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .responseJSON()
        
        let jsonResponse = JSON(response.result.value!)
        if (response.result.isFailure || !jsonResponse["errors"].isEmpty) {
            print("Error updating user")
            return
        }
                
        for r in jsonResponse["data"].arrayValue {
            let record = Record()
            record.id = r["id"].int
            record.dateTime = r["date"].string
            record.glycemia = r["glycemia"].int
            record.carbohydrates = r["carbohydrates"].int
            record.mealInsulin = r["meal_insulin"].float
            record.correctionInsulin = r["correction_insulin"].float
            record.activity = r["activity"].float
            record.notes = r["notes"].string
            AppDelegate.database.records.append(record)
        }
    }
}
