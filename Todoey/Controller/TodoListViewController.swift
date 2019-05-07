//
//  ViewController.swift
//  Todoey
//
//  Created by Jeremy Adam on 05/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [ToDoModel]()
    let keyDefaultToDoList = "ToDoListItem"
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newItem = ToDoModel("Eating", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating1", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating2", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating3", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating4", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating5", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating6", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating7", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating8", false)
        itemArray.append(newItem)
        newItem = ToDoModel("Eating9", false)
        itemArray.append(newItem)
        
        
//        if let items = defaults.value(forKey: keyDefaultToDoList) as? [String] {
//            itemArray = items
//        }
        
    }

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
            
            let newItem = ToDoModel(textField.text!, false)
            //Add new item to item Array
            self.itemArray.append(newItem)
            
//            self.defaults.setValue(self.itemArray, forKey: self.keyDefaultToDoList)
            
            //Reload Table View
            self.tableView.reloadData()
            
        }
        
        // Attach action to alert
        alert.addAction(alertAddAction)
        
        //Show alert to user
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].status {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        itemArray[indexPath.row].status = !itemArray[indexPath.row].status
        
        tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

}

