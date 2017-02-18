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

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentSender: Any!
    
    var pickerData: Array<String>!
    var picker: UIPickerView!
    var pickerToolBar: UIToolbar!
    
    @IBOutlet weak var glycemiaUnitField: UITextField!
    @IBOutlet weak var carbohydratesToUnitField: UITextField!
    @IBOutlet weak var targetGlycemiaField: UITextField!
    @IBOutlet weak var insulinToUnitField: UITextField!
    @IBOutlet weak var correctionFactorField: UITextField!
    @IBOutlet weak var hyperglycemiaThresholdField: UITextField!
    @IBOutlet weak var hypoglycemiaThresholdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker = buildUIPickerView()
        self.pickerToolBar = buildPickerToolBar()
        
        loadValuesToUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveButtonClick(_ sender: UIBarButtonItem) {
        let params: Parameters = ["glycemia_unit": glycemiaUnitField.text!,
                                  "carbohydrates_to_unit": carbohydratesToUnitField.text!,
                                  "target_glycemia":targetGlycemiaField.text!,
                                  "insulin_to_unit": insulinToUnitField.text!,
                                  "correction_factor": correctionFactorField.text!,
                                  "hyperglycemia_threshold": hyperglycemiaThresholdField.text!,
                                  "hypoglycemia_threshold": hypoglycemiaThresholdField.text!]
        
        AppDelegate.database.currentUser.update(params: params, completion: { (response: Alamofire.DataResponse<Any>) -> Void in
            if response.result.isSuccess {
                let attrs = JSON(response.result.value!)["data"]["user"]
                print(attrs)
                AppDelegate.database.currentUser.localUpdate(attrs: attrs)
            } else {
                print("Error updating user")
            }
        })
    }
    
    @IBAction func glycemiaUnitFieldEditingDidBegin(_ sender: UITextField) {
        self.currentSender = sender
        self.pickerData = ["mg/dl", "mmol/L"]
        sender.inputView = self.picker
        sender.inputAccessoryView = self.pickerToolBar
    }
    
    private func buildUIPickerView() -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }
    
    private func buildPickerToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: #selector(cancelPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItemStyle.plain,
                                         target: self,
                                         action: #selector(donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolBar
    }
    
    private func loadValuesToUI() {
        let currentUser = AppDelegate.database.currentUser
        
        self.glycemiaUnitField.text = currentUser.glycemiaUnit
        self.carbohydratesToUnitField.text = String(currentUser.carbohydratesToUnit)
        self.targetGlycemiaField.text = String(currentUser.targetGlycemia)
        self.insulinToUnitField.text = String(currentUser.insulinToUnit)
        self.correctionFactorField.text = String(currentUser.correctionFactor)
        self.hyperglycemiaThresholdField.text = String(currentUser.hyperGlycemiaThreshold)
        self.hypoglycemiaThresholdField.text = String(currentUser.hypoGlycemiaThreshold)
    }
    
    // Picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func cancelPicker(_ sender: UIBarButtonItem) {
        let textField = currentSender as! UITextField
        textField.endEditing(true)
    }
    
    func donePicker(_ sender: UIBarButtonItem) {
        let textField = currentSender as! UITextField
        textField.text = pickerData[picker.selectedRow(inComponent: 0)]
        cancelPicker(sender)
    }
}
