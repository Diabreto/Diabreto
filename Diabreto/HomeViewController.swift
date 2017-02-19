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
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGraph()
        setupWarning(type: "up", glycemiaValue: "140")
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
            let begin = record.dateTime.index(record.dateTime.startIndex, offsetBy: 12)
            let end = record.dateTime.index(record.dateTime.startIndex, offsetBy: 16)
            return record.dateTime.substring(with: begin..<end)
        })
        
        let blue: UIColor = UIColor(red: 34/255, green: 154/255, blue: 255/255, alpha: 1)
        
        self.graphView.shouldAdaptRange = true
        self.graphView.lineWidth = 2
        self.graphView.lineColor = blue
        self.graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        self.graphView.shouldFill = true
        self.graphView.fillType = ScrollableGraphViewFillType.gradient
        self.graphView.fillGradientType = ScrollableGraphViewGradientType.linear
        self.graphView.fillGradientStartColor = UIColor(red: 34/255, green: 154/255, blue: 255/255, alpha: 0.005)
        self.graphView.fillGradientEndColor = UIColor(red: 34/255, green: 154/255, blue: 255/255, alpha: 0.05)
        
        self.graphView.dataPointSpacing = 80
        self.graphView.dataPointSize = 4
        self.graphView.dataPointFillColor = blue
        
        self.graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        self.graphView.referenceLineColor = UIColor(red: 34/255, green: 154/255, blue: 255/255, alpha: 0.2)
        self.graphView.referenceLineLabelColor = UIColor.black
        self.graphView.dataPointLabelColor = UIColor.black
        
        self.graphView.set(data: data, withLabels: labels)
    }
    
    private func setupWarning(type: String, glycemiaValue: String) {
        let blue: UIColor = UIColor(red: 34/255, green: 154/255, blue: 255/255, alpha: 1)
        let red: UIColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        
        if type == "up" {
            warningView.backgroundColor = red
            warningLabel.backgroundColor = red
            warningLabel.text = "Aviso: tendencia para aumetar para \(glycemiaValue)"
        } else {
            warningView.backgroundColor = blue
            warningLabel.backgroundColor = blue
            warningLabel.text = "Aviso: tendencia para descer para \(glycemiaValue)"
        }
    }
    
    // Table View
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.database.records.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = AppDelegate.database.records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell

        cell.recordImageView.layer.cornerRadius = 37
        cell.recordImageView.layer.masksToBounds = true
        cell.recordImageView.image = UIImage(named: "meal\((indexPath.row % 4) + 1)")
        cell.glycemiaLabel.text = String(record.glycemia)
        cell.carbohydratesLabel.text = String(record.carbohydrates)
        cell.mealInsulinLabel.text = String(record.mealInsulin)
        cell.correctionInsulinLabel.text = String(record.correctionInsulin)
        
        return cell
    }
    
}
