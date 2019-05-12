//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jeremy Adam on 09/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories:Results<Category>?
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category Name"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            
            newCategory.name = textField.text!
            newCategory.bgColorHex = (UIColor.randomFlat()?.hexValue())!
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        //Show alert to user
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].bgColorHex ?? "1D9BF6")
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //GO TO Item
        performSegue(withIdentifier: "goToDetail", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    //MARK: - Manipulate CoreData by context
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error Saving Context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //Load Items
    func loadCategories() {
       
        categories = realm.objects(Category.self)
        self.tableView.reloadData()
    }
    
    //Delete Data
    override func updateModel(at indexPath: IndexPath) {
        
        //DELETION Realm
        if let deleteSelectedCategory = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(deleteSelectedCategory)
                    print("Success Deleted")
                }
            }
            catch {
                print("Error while delete, \(error)")
            }
        }
    }
}
