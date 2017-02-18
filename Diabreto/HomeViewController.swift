//
//  ViewController.swift
//  Diabreto
//
//  Created by Tiago Botelho on 17/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var glucose = [102,205,70,102,205,70,102,205,70]
    var carbs = [15,5,50,0,0,70,32,0,70]
    var photoMeals = ["meal",]
    var insulinMeal = [0.5,2.5,2.3,1.8,20.3,25.7,0,0,0]
    var insulinCorrection = [0.5,0,3.0,0,0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glucose.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        cell.mealImage.image = UIImage(named: "meal")
        
        if glucose[indexPath.row] == 0 {
            cell.glucoseDisplay.text = "-"
        }
        else{
            cell.glucoseDisplay.text = String(glucose[indexPath.row])
        }
        
        if carbs[indexPath.row] == 0 {
            cell.carbsDisplay.text = "-"
        }
        else{
            cell.carbsDisplay.text = String(describing: carbs[indexPath.row])
        }
        
        if insulinMeal[indexPath.row] == 0 {
            cell.InsMealDisplay.text = "-"
        }
        else{
            cell.InsMealDisplay.text = String(insulinMeal[indexPath.row])
        }
        
        if insulinCorrection[indexPath.row] == 0 {
            cell.CorrectionDisplay.text = "-"
        }
        else{
            cell.CorrectionDisplay.text = String(insulinCorrection[indexPath.row])
        }
        
        return (cell)
    }
    
}
