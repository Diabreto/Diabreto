import UIKit

class RecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChooseCarbsDelegate {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var glucoseTextField: UITextField!
    @IBOutlet weak var carbsTextField: UITextField!
    @IBOutlet weak var mealInsulinTextField: UITextField!
    @IBOutlet weak var correctionTextField: UITextField!
    @IBOutlet weak var activitySlider: UISlider!
    @IBOutlet weak var sliderPercentageField: UILabel!
    @IBOutlet weak var totalTextView: UITextField!
    
    let color = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.00)
    let radius = 5
    let border = 1
    let currentUser = AppDelegate.database.currentUser
    
    var selectedFood = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RecordViewController.dismissKeyboard))
        self.navigationController?.navigationBar.topItem?.title = "New Record"

        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.layer.borderWidth = CGFloat(border)
        self.tableView.layer.borderColor = color.cgColor
        self.tableView.layer.cornerRadius =  CGFloat(radius)

        view.addGestureRecognizer(tap)
        configureTextBoxes()
        dateTextField.text = dateFormatter(date: Date())
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func total() -> Float {
        var total:Float = 0.0
        if !(mealInsulinTextField.text?.isEmpty)! {
            total += Float(mealInsulinTextField.text!)!
        }
        
        if !(correctionTextField.text?.isEmpty)! {
            total += Float(correctionTextField.text!)!
        }
        
        return Float(total)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "New Record"

        super.viewDidAppear(animated)
        self.tableView.flashScrollIndicators()
    }

    @IBAction func carbsOnChange(_ sender: UITextField) {
        let value = Float(sender.text!)! / currentUser.insulinToUnit
        self.mealInsulinTextField.text = String(value)
        
        updateTotalFieldVal()
    }
    
    @IBAction func glucoseOnChange(_ sender: UITextField) {
        let correction = (Float(sender.text!)! - Float(currentUser.targetGlycemia)) / Float(currentUser.correctionFactor)
        
        correctionTextField.text = String.localizedStringWithFormat("%.2f", correction)
        
        updateTotalFieldVal()
    }
    
    func updateTotalFieldVal() {
        self.totalTextView.text = String(total())
    }

    @IBAction func activityOnChange(_ sender: UISlider) {
        self.sliderPercentageField.text = String(Int(sender.value))
        
        if !(totalTextView.text?.isEmpty)! && sender.value != 0.0 {
            let variance = total() * (sender.value / 100)

            totalTextView.text = String.localizedStringWithFormat("%.2f", total() + variance)
        }
    }
    
    @IBAction func dateEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        
        datePickerView.addTarget(
            self,
            action: #selector(RecordViewController.datePickerValueChanged),
            for: UIControlEvents.primaryActionTriggered
        )
        datePickerView.addTarget(
            self,
            action: #selector(RecordViewController.datePickerValueChanged),
            for: UIControlEvents.valueChanged
        )
    }

    func selectCells(foodList: [Food]) {
        var carbs: Float = 0.0
        self.selectedFood = foodList
        
        for food:Food in self.selectedFood {
            carbs += (food.carbs * Float(food.dosage))/100.0
        }

        carbsTextField!.text! = String(carbs)
        mealInsulinTextField.text = String(carbs / currentUser.insulinToUnit)
        updateTotalFieldVal()
        self.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedFood.count
    }
    
    @IBAction func createRecord(_ sender: Any) {
        var glycemia = -1
        var carbohydrates = -1
        var mealInsulin = Float(-1.0)
        var correctionInsulin = Float(-1.0)
        
        if (glucoseTextField.text != nil) {
            glycemia = Int(glucoseTextField.text!)!
        }
        
        if (carbsTextField.text != nil) {
            carbohydrates = Int(carbsTextField.text!)!
        }
        
        if (mealInsulinTextField.text != nil) {
            mealInsulin = Float(mealInsulinTextField.text!)!
        }
        
        if (correctionTextField.text != nil) {
            correctionInsulin = Float(correctionInsulin)
        }
        
        let record = Record(
            dateTime: dateTextField.text!,
            glycemia: glycemia,
            carbohydrates: carbohydrates,
            mealInsulin: mealInsulin,
            correctionInsulin: correctionInsulin,
            activity: Float(activitySlider.value)
            )
        
        AppDelegate.database.records.append(record)
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! RecordTableViewCell
        
        cell.Food.text = self.selectedFood[indexPath.row].name
        cell.Carbs.text = String(self.selectedFood[indexPath.row].carbs)
        cell.Dosage.text = String(self.selectedFood[indexPath.row].dosage)
        cell.viewController = self
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController = segue.destination as! CarbsTableViewController
        destViewController.delegate = self
        
        self.tableView.reloadData()
    }
    
    @IBAction func onCarbsValueChanged(_ sender: UITextField) {
        self.mealInsulinTextField.text = String(Float(sender.text!)!/currentUser.insulinToUnit)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) { dateTextField.text = dateFormatter(date: sender.date) }
    
    private func dateFormatter(date:Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
    
    private func configureTextBoxes() {
        for view in self.view.subviews {
            if (view is UITextField) {
                view.layer.borderWidth = CGFloat(border)
                view.layer.cornerRadius = CGFloat(radius)
                view.layer.borderColor = color.cgColor
            }
        }
    }
}
