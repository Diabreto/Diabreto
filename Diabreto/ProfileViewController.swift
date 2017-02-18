//
//  ViewController.swift
//  Diabreto
//
//  Created by Tiago Botelho on 17/02/2017.
//  Copyright © 2017 Diabreto. All rights reserved.
//

import UIKit

enum PickerType {
    case glycemiaUnit
}

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentSender: Any!
    
    var pickerData: Array<String>!
    var picker: UIPickerView!
    var pickerToolBar: UIToolbar!
    
    @IBOutlet weak var glycemiaUnitField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker = buildUIPickerView()
        self.pickerToolBar = buildPickerToolBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func glycemiaUnitFieldEditingDidBegin(_ sender: UITextField) {
        self.currentSender = sender
        self.pickerData = ["mg/dl", "mmol/L"]
        sender.inputView = self.picker
        sender.inputAccessoryView = self.pickerToolBar
    }
    
    @IBAction func carbohydratesUnitFieldEditingDidBegin(_ sender: UITextField) {
        self.currentSender = sender
        self.pickerData = ["Equivalence", "Grams"]
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
