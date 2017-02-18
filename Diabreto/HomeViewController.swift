//
//  ViewController.swift
//  Diabreto
//
//  Created by Tiago Botelho on 17/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import UIKit
import SwiftyJSON
import ScrollableGraphView

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var graphView: ScrollableGraphView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupGraph() {
        let data = AppDelegate.database.records.map({ record -> Double in
            return Double(record.glycemia)
        })
        let labels = AppDelegate.database.records.map({ record -> String in
            let index = record.dateTime.index(record.dateTime.startIndex, offsetBy: 10)
            return record.dateTime.substring(to: index)
        })
        
        self.graphView.backgroundFillColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        self.graphView.shouldAdaptRange = true
        
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
        return AppDelegate.database.records.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = AppDelegate.database.records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        cell.recordImageView.image = UIImage(named: "meal")
        cell.glycemiaLabel.text = String(record.glycemia)
        cell.carbohydratesLabel.text = String(record.carbohydrates)
        cell.mealInsulinLabel.text = String(record.mealInsulin)
        cell.correctionInsulinLabel.text = String(record.correctionInsulin)
        
        return cell
    }
    
}
