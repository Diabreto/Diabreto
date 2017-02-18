//
//  ViewController.swift
//  Diabreto
//
//  Created by Tiago Botelho on 17/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import UIKit
import ScrollableGraphView

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var graphView: ScrollableGraphView!
    
    var glucose = [102,205,70,102,205,70,102,205,70]
    var carbs = [15,5,50,0,0,70,32,0,70]
    var photoMeals = ["meal",]
    var insulinMeal = [0.5,2.5,2.3,1.8,20.3,25.7,0,0,0]
    var insulinCorrection = [0.5,0,3.0,0,0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupGraph() {
        let data: [Double] = [4, 8, 15, 16, 23, 42]
        let labels = ["one", "two", "three", "four", "five", "six"]
        
        self.graphView.backgroundFillColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        
        self.graphView.lineWidth = 1
        self.graphView.lineColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
        self.graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        self.graphView.shouldFill = true
        self.graphView.fillType = ScrollableGraphViewFillType.gradient
        self.graphView.fillColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        self.graphView.fillGradientType = ScrollableGraphViewGradientType.linear
        self.graphView.fillGradientStartColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        self.graphView.fillGradientEndColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
        
        self.graphView.dataPointSpacing = 80
        self.graphView.dataPointSize = 2
        self.graphView.dataPointFillColor = UIColor.white
        
        self.graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        self.graphView.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        self.graphView.referenceLineLabelColor = UIColor.white
        self.graphView.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        self.graphView.set(data: data, withLabels: labels)
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
