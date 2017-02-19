//
//  ViewController.swift
//  Diabreto
//
//  Created by Tiago Botelho on 17/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RecordViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonClick(_ sender: Any) {
        let response: DataResponse<Any> = User.login()
        
        let jsonResponse = JSON(response.result.value!)
        if (response.result.isFailure || !jsonResponse["errors"].isEmpty) {
            print("Login errror")
            return
        }
        
        // Save user locally
        AppDelegate.database.currentUser.localUpdate(attrs: jsonResponse["data"]["user"])
        
        // Get user records
        Record.getRecords()
    }
}
