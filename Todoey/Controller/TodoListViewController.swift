//
//  ViewController.swift
//  Todoey
//
//  Created by Jeremy Adam on 05/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    
    //MARK: - Variable
    var itemArray = [Item]()
    let keyDefaultToDoList = "ToDoListItem"
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
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
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.status = false
            
            //Add new item to item Array
            self.itemArray.append(newItem)
            
            //Save Item to CoreData and Reload Table View
            self.saveItems()
        }
        
        // Attach action to alert
        alert.addAction(alertAddAction)
        
        //Show alert to user
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        cell.accessoryType = itemArray[indexPath.row].status == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        itemArray[indexPath.row].status = !itemArray[indexPath.row].status
        
        saveItems()

        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    //MARK: - Manipulate CoreData by context
    func saveItems() {
        do {
            try context.save()
        }
        catch {
            print("Error Saving Context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //Load Items parameter using default value using = xxxx
    func loadItems(_ request:NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        self.tableView.reloadData()
    }
}

//MARK: - Search Bar Extension
extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request:NSFetchRequest<Item> = Item.fetchRequest()

        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        loadItems(request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        }
    }
}

