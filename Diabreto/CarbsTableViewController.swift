import UIKit
import SwiftyJSON

protocol ChooseCarbsDelegate {
    func selectCells(foodList: [Food])
}

class CarbsTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var delegate : ChooseCarbsDelegate? = nil
    
    var searchController : UISearchController!
    var foods = [Food]()
    var filteredFoods = [Food]()
    var selectedFoods = [Food]()
    
    @IBOutlet weak var carbsTableNavBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Add"
        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        loadFoods()
        configureSearchBar()
    }
    
    func done() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.showsCancelButton = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.tableView.allowsMultipleSelection = true
        self.definesPresentationContext = true
    }
    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        self.filteredFoods = self.foods.filter { (food:Food) -> Bool in
            return food.name.lowercased().contains((searchController.searchBar.text?.lowercased())!)
        }
        
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.isActive && self.searchController.searchBar.text != "") {
            return self.filteredFoods.count
        } else {
            return self.foods.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        let name_result:String!
        let carbs_result:String!
        
        if (self.searchController.isActive && self.searchController.searchBar.text != "") {
            name_result = self.filteredFoods[indexPath.row].name
            carbs_result = "\(self.filteredFoods[indexPath.row].carbs)"
        } else {
            name_result = self.foods[indexPath.row].name
            carbs_result = "\(self.foods[indexPath.row].carbs)"
        }
        
        if ((self.selectedFoods.filter({$0.name == name_result}).first) != nil) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        
        cell.textLabel?.text = name_result
        cell.detailTextLabel?.text = carbs_result
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableViewVal = self.tableView.cellForRow(at: indexPath)
        
        if let found = self.foods.filter({$0.name == tableViewVal?.textLabel?.text}).first {
            self.selectedFoods.append(found)
        }
        
        if (self.delegate != nil)  {
            self.delegate?.selectCells(foodList: self.selectedFoods)
        }
        
        tableViewVal?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let tableViewVal = self.tableView.cellForRow(at: indexPath)
        self.selectedFoods = self.selectedFoods.filter(){$0.name != tableViewVal?.textLabel?.text}
        
        
        if (self.delegate != nil)  {
            self.delegate?.selectCells(foodList: self.selectedFoods)
        }
        
        tableViewVal?.accessoryType = .none
    }
    
    private func loadFoods() {
        let path = Bundle.main.path(forResource: "CarbsTable", ofType: "json")
        let content = FileManager.default.contents(atPath: path!)
        let json = JSON(data: content!)
        
        for (_, value): (String, JSON) in json {
            self.foods.append(
                Food(
                    name: format(value: value["name"].stringValue),
                    carbs: value["carbs"].floatValue
                )
            )
        }
    }
    
    private func format(value: String) -> String {
        return value.replacingOccurrences(of: "\"", with: "")
    }
    
    deinit{
        self.searchController?.view.removeFromSuperview()
    }
}
