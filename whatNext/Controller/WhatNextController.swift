//
//  ViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/25/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit
import CoreData

class WhatNextController: UITableViewController, UISearchBarDelegate {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        
        didSet{
            
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //File Path and Create custom plist
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = selectedCategory?.name
        
        //Hardcode itemArray
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
        
        
        //loadItems()

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
        
        //Remove Item
      
//        context.delete(itemArray[indexPath.row])
//
//        itemArray.remove(at: indexPath.row)
        
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
            
            let newItem = Item(context: self.context)
            
            newItem.title = textFieldInAlert.text!
            
            self.itemArray.append(newItem)
            
            newItem.parentCategory = self.selectedCategory
            
            newItem.done = false
            
            self.saveItems()
            
            //self.defaults.set(self.itemArray, forKey: "whatNextItemArray")
            
            //TODO:- Call saveItems method
       
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
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {

        do {
           try context.save()
            
        } catch {
            
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(),with predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        } else {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate])
            
        }
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
        
        do {
             itemArray =  try context.fetch(request)
            
        } catch {
            
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}

//MARK: - Search Bar Methods

extension WhatNextController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request :  NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, with: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
        }
    }
}
    

