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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonClick(_ sender: Any) {
        User.login(completion: { (response: DataResponse<Any>) -> Void in
            if response.result.isSuccess {
                let attrs = JSON(response.result.value!)["data"]["user"]
                AppDelegate.database.currentUser.localUpdate(attrs: attrs)
            } else {
                print("Login error")
            }
        })
    }
}
