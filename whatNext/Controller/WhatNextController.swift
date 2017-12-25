//
//  ViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/25/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit

class WhatNextController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    //File Path and Create custom plist
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    //print(dataFilePath)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Hardcode itemArray
        
//        let newItem = Item()
//
//        newItem.title = "Swift"
//
//        itemArray.append(newItem)
//
//
//        let newItem2 = Item()
//
//        newItem2.title = "PHP"
//
//        itemArray.append(newItem2)
        
//        if let items = defaults.array(forKey: "whatNextItemArray") as? [Item] {
//            itemArray = items
//        }
        loadItems()

    }
    //MARK: - TableView DataSource Delegate Methods
    
    //Set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhatNextItemCell", for: indexPath)
        
        //Display cell
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        return cell
        
    }

    //MARK: - TableView Delegate Mehods
    
    //Fire when user clicks on cell
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //TODO:- Call saveItems method
        
        saveItems()
        
        //TODO: - Add and Remove checkmark as user clicks on
        
        if itemArray[indexPath.row].done {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
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
            
            let newItem = Item()
            
            newItem.title = textFieldInAlert.text!
            
            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "whatNextItemArray")
            
            //TODO:- Call saveItems method
            
            self.saveItems()
            
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
    
    //MARK: - Model Manipulation Method
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data =  try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
            
        } catch {
            
            print("Error encoding item array \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do {
                
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Cannot decode itemArray \(error)")
            }
            
        }
    }


}

