//
//  User.swift
//  Diabreto
//
//  Created by João Bernardo on 18/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

class Database {
    var currentUser: User
    var records: [Record]
    
    init() {
        self.currentUser = User()
        self.records = []
    }
}
