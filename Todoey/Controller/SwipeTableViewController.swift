//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Jeremy Adam on 12/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - TableView DataSource Mehtods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil}
        
        
        let moreAction = SwipeAction(style: .default, title: "More") { (action, indexPath) in
            print("more detail")
            
            self.performSegue(withIdentifier: "goToDetail", sender: self)
        }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("starting deleting")
            self.updateModel(at: indexPath)
        }
        
        moreAction.image = UIImage(named: "more-icon")
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction, moreAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel(at indexPath:IndexPath) {
        //Update data model
    }
    
}
