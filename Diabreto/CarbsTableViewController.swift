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
        loadFoods()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        searchController.dimsBackgroundDuringPresentation = false
        
        self.tableView.tableHeaderView = searchController.searchBar
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
        
        if (searchController.isActive && searchController.searchBar.text != "") {
            name_result = filteredFoods[indexPath.row].name
            carbs_result = "\(filteredFoods[indexPath.row].carbs)"
        } else {
            name_result = foods[indexPath.row].name
            carbs_result = "\(foods[indexPath.row].carbs)"
        }
        
        if ((selectedFoods.filter({$0.name == name_result}).first) != nil) {
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
        
        if let found = foods.filter({$0.name == tableViewVal?.textLabel?.text}).first {
            self.selectedFoods.append(found)
        }
        
        if (delegate != nil)  {
            delegate?.selectCells(foodList: selectedFoods)
        }
        
        tableViewVal?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let tableViewVal = self.tableView.cellForRow(at: indexPath)
        self.selectedFoods = self.selectedFoods.filter(){$0.name != tableViewVal?.textLabel?.text}
        
        
        if (delegate != nil)  {
            delegate?.selectCells(foodList: selectedFoods)
        }
        
        tableViewVal?.accessoryType = .none
    }
    
    private func loadFoods() {
        let path = Bundle.main.path(forResource: "CarbsTable", ofType: "json")
        let content = FileManager.default.contents(atPath: path!)
        let json = JSON(data: content!)
        
        for (_, value): (String, JSON) in json {
            foods.append(
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
