//
//  ViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/25/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
class WhatNextController: SwipeTableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var whatNextItems : Results<Item>?
    
    let realm = try! Realm()
    
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
    
    //View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {
            
            fatalError("Navigation Controller does not exist")
            
        }
        
        guard let colorHex = selectedCategory?.hexColor else {
            
            fatalError()
            
        }
            
            guard let navBarColor = UIColor(hexString: colorHex) else {
                
                fatalError()
                
            }
    
        super.addNavBarColor(with: navBar, color: navBarColor)
        
        searchBar.barTintColor = navBarColor
        
    }
    
    //View Will DissAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let defaultHexColor : String = "#034287"
        
        guard let defaultColor : UIColor = UIColor(hexString: defaultHexColor) else {
            
            fatalError("Cannot convert defaultHexColor into UIColor")
        }
        
        guard let navBar = navigationController?.navigationBar else {
            
            fatalError("Navigation Controller does not exist")
        }
        
        super.addNavBarColor(with: navBar, color: defaultColor)
        
    }
    
    //MARK: - TableView DataSource Delegate Methods
    
    //Set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return whatNextItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WhatNextItemCell", for: indexPath)
        
        //Display cell
        
        if let item = whatNextItems?[indexPath.row] {
            
            cell.textLabel?.text = whatNextItems?[indexPath.row].title
            
            let percentDarkened : CGFloat = indexPath.row != 0 ? CGFloat(indexPath.row) / CGFloat(whatNextItems!.count) : 0.1
            
            if let color =  UIColor(hexString: selectedCategory!.hexColor!)?.darken(byPercentage: percentDarkened ) {
                
                cell.backgroundColor = color
                
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                
            }
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
        
    }

    //MARK: - TableView Delegate Mehods
    
    //Fire when user clicks on cell
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = whatNextItems?[indexPath.row] {
          
            do {
                
                try realm.write {
                    
                    //Delete object in database
                    
                    //realm.delete(item)
                    
                    item.done = !item.done
                }
                
            } catch {
                
                print("Error saving done status \(error)")
                
            }
   
        }
        
        tableView.reloadData()
        
        //print(itemArray[indexPath.row])
        
        //Remove Item
      
//        context.delete(itemArray[indexPath.row])
//
//        itemArray.remove(at: indexPath.row)
        
//        whatNextItems?[indexPath.row].done = !whatNextItems?[indexPath.row].done
        
        //TODO:- Call saveItems method
        
        //saveItems()
        
        //TODO: - Add and Remove checkmark as user clicks on
        
//        if whatNextItems?[indexPath.row].done {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
       
        //Effects as user deselects it
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Back to Root
    
    @IBAction func backToRoot(_ sender: UIBarButtonItem) {
        
        navigationController?.popToRootViewController(animated: true)
        
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
            
//            let newItem = Item()
//            
//            newItem.title = textFieldInAlert.text!
//            
//            self.itemArray.append(newItem)
//            
//            newItem.parentCategory = self.selectedCategory
//            
//            newItem.done = false
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    
                    try self.realm.write {
                        
                        let newItem = Item()
                        
                        newItem.title = textFieldInAlert.text!
                        
                        newItem.done = false
                        
                        newItem.createdAt = Date()
                        
                        currentCategory.items.append(newItem)
                        
                        self.realm.add(newItem)
                        
                    }
                    
                } catch {
                    
                    print("Error saving realm \(error)")
                    
                }
       
            }
            
            self.tableView.reloadData()
            
            //newItem.parentCategory = self.selectedCategory
      
            //self.saveItems()
            
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
    
    //TODO:- Save Items
    
    func saveItems() {

        do {
           try context.save()
            
        } catch {
            
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    //TODO:- Load Items
    
    func loadItems() {
        
        whatNextItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//
//        } else {
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate])
//
//        }
//
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
////
////        request.predicate = compoundPredicate
//
//        do {
//             itemArray =  try context.fetch(request)
//
//        } catch {
//
//            print("Error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
    }
    
    //TODO:- Delete Items From Swipe
    
    override func updateDeletion(at indexPath: IndexPath) {
        
        if let item = whatNextItems?[indexPath.row] {
            
            do {
                
                try realm.write {
                    
                     realm.delete(item)
                    
                }
                
            } catch {
                
                print("Error deleting item \(error)")
            }

        }
        
    }
    
    //TODO:- Edit Categories From Swipe
    
    override func updateEdit(at indexPath: IndexPath) {
        
        var textField : UITextField = UITextField()
        
        //TODO:- Add Alert
        
        let alert = UIAlertController(title: "Edit Item", message: "", preferredStyle: .alert)
        
        if let item = self.whatNextItems?[indexPath.row] {
            
            alert.addTextField { textFieldAlert in
                
                textField = textFieldAlert
                
                textField.placeholder = item.title
            }
            
            //TODO:- Add Action
            
            let action = UIAlertAction(title: "Edit", style: .default, handler: { action in
                
                do {
                    
                    try self.realm.write {
                        
                        
                        
                        if textField.text!.count != 0 {
                            
                            item.title = textField.text!
                        }
                        
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    
                    print("Error in editting item \(error)")
                    
                }
                
            })
            
            alert.addAction(action)
            
            //TODO:- Show Alert
            
            present(alert, animated: true, completion: nil)
            
        }
    }
}

//MARK: - Search Bar Methods

extension WhatNextController {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        whatNextItems = whatNextItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "createdAt", ascending: true)
        
        tableView.reloadData()

//        let request :  NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, with: predicate)

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()

            DispatchQueue.main.async {

                searchBar.resignFirstResponder()
            }
        }
        
        tableView.reloadData()
    }
    
    
}


