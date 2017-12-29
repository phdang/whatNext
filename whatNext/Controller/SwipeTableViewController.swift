//
//  SwipeTableViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/27/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        tableView.separatorStyle = .none
        
    }
    
    //TableView Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
        
        
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
            //print(indexPath.row)
            //print("Delete Cell")
            
            self.updateDeletion(at: indexPath)

        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        let editAction = SwipeAction(style: .default, title: "Edit") { (action, indexPath) in
            
            self.updateEdit(at: indexPath)
            
        }
        
        editAction.image = UIImage(named: "edit-icon")
        
        editAction.backgroundColor = FlatOrange()
        
        if navigationItem.title == "whatNext" {
            
            let colorAction = SwipeAction(style: .default, title: "Color") { (action, indexPath) in
                
                self.updateColor(at: indexPath)
                
            }
            
            colorAction.image = UIImage(named: "flag-icon")
            
            colorAction.backgroundColor = FlatSkyBlue()
            
            return [deleteAction, editAction, colorAction]
            
        } else if navigationItem.title == "Color" {
            
            return nil
            
        }
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        
        options.expansionStyle = .destructive
        
        options.transitionStyle = .border
        
        return options
    }
    
    func updateDeletion (at indexPath : IndexPath) {
        
    }
    
    func updateEdit ( at indexPath: IndexPath) {
        
    }
    
    func updateColor ( at indexPath: IndexPath) {
        
    }
    
    func addNavBarColor(with navBar: UINavigationBar, color: UIColor) {
        
        navBar.barTintColor = color
        
        navBar.tintColor = ContrastColorOf(color, returnFlat: true)
        
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ContrastColorOf(color, returnFlat: true)]
        
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ContrastColorOf(color, returnFlat: true)]
        
        view.backgroundColor = color
    }
}

