import UIKit

class RecordViewController: UIViewController, ChooseCarbsDelegate {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    var selectedFoovar = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextBoxes()
        dateTextField.text = dateFormatter(date: Date())
    }
    
    @IBAction func activityOnChange(_ sender: UITextField) {
        if (!(sender.text == "")) {
            sender.text = sender.text! + "%"
        }
    }
    
    @IBAction func dateEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        
        datePickerView.addTarget(
            self, action:
            #selector(RecordViewController.datePickerValueChanged),
            for: UIControlEvents.primaryActionTriggered
        )
        datePickerView.addTarget(
            self, action:
            #selector(RecordViewController.datePickerValueChanged),
            for: UIControlEvents.valueChanged
        )
    }
    
    func selectCells(cell: [Food]) {
        print(cell.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController = segue.destination as! CarbsTableViewController
        destViewController.delegate = self
    }
    
    func datePickerValueChanged(sender:UIDatePicker) { dateTextField.text = dateFormatter(date: sender.date) }
    
    private func dateFormatter(date:Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
    
    private func configureTextBoxes() {
        let color = UIColor(red:0.82, green:0.82, blue:0.83, alpha:1.00)
        let radius = 5
        let border = 1
        
        notesTextField.layer.borderWidth = CGFloat(border)
        notesTextField.layer.cornerRadius = CGFloat(radius)
        notesTextField.layer.borderColor = color.cgColor
        
        for view in self.view.subviews {
            if (view is UITextField) {
                view.layer.borderWidth = CGFloat(border)
                view.layer.cornerRadius = CGFloat(radius)
                view.layer.borderColor = color.cgColor
            }
        }
    }
}
