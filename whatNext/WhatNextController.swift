//
//  ViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/25/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit

class WhatNextController: UITableViewController {

    var itemArray = ["PHP Session", "PHP Cookie", "Swift CoreData", "Swift Singleton"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "whatNextItemArray") as? [String] {
            itemArray = items
        }
    }
    //MARK: - TableView DataSource Delegate Methods
    
    //Set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhatNextItemCell", for: indexPath)
        
        //Display cell
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }

    //MARK: - TableView Delegate Mehods
    
    //Fire when user clicks on cell
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //TODO: - Add and Remove checkmark as user clicks on
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       
        //Effects as user deselects it
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Add items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //print("Triggered")
        
        var textFieldInAlert = UITextField()
        
        //Add Alert Controller
        
        let alert = UIAlertController(title: "Add new whatNext item", message: "", preferredStyle: .alert)
        
        //What will happen once user click on add item on UIAlert
        
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            
            //print("Success!")
            
            self.itemArray.append(textFieldInAlert.text!)
            
            self.defaults.set(self.itemArray, forKey: "whatNextItemArray")
            
            self.tableView.reloadData()
            
        }
        
        //Add alert Textfield
        
        alert.addTextField { textField in
            textField.placeholder = "Create new item"
            
            textFieldInAlert = textField
            
        }
        
        //Add action
        
        alert.addAction(action)
        
        //Show alert
        
        present(alert, animated: true, completion: nil)
    }
    


}

