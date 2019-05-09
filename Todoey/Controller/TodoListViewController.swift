//
//  ViewController.swift
//  Todoey
//
//  Created by Jeremy Adam on 05/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    
    //MARK: - Variable
    
    var selectedCategory:Category? {
        didSet {
            loadItems()
        }
    }
    
    var toDoItems: Results<Item>?
    let realm = try! Realm()
    let keyDefaultToDoList = "ToDoListItem"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //When Plus + button Pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        //Add Alert
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        //Add TextField to Alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Item Name"
            textField = alertTextField
        }
        
        //Add Add Action (Button in Alert)
        let alertAddAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                        
                    }
                }
                catch {
                    print("Error Saving Context \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        // Attach action to alert
        alert.addAction(alertAddAction)
        
        //Show alert to user
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    //Cell For Row At
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.status == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    //Number Of Rows In Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    //Did Select Row At
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let currentRow = toDoItems?[indexPath.row] {
            do {
                try realm.write {
//                    realm.delete(currentRow)
                    currentRow.status = !currentRow.status
                }
            } catch {
                print("Error saving Status, \(error)")
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }

    
    
    
    
    
    //MARK: - Manipulate CoreData by context
    
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        self.tableView.reloadData()
    }
}




//MARK: - Search Bar Extension
extension TodoListViewController : UISearchBarDelegate {
    
    //When Search Bar Button Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        self.tableView.reloadData()
    }

    //When Search bar Text did change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

