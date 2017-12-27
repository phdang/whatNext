//
//  CategoryTableViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/26/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            
            fatalError("Navigation Controller does not exist yet!")
        }
        
        view.backgroundColor = navBar.barTintColor
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
//        
//        cell.delegate = self
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added yet!"
        
        addColor(cell: cell, at: indexPath.row)
  
        return cell
    }
    
    // MARK:- Data Manipulation Methods
    
    
    
    // TODO:- Save Categories Methods
    
    func save(category: Category) {
        
        
        do {
            
            try realm.write {
                
                realm.add(category)
                
            }
            
        } catch {
            
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    // TODO:- Load Categories Methods
    
    func loadCategories() {
        
         categories = realm.objects(Category.self)
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        
//        do {
//            
//            try categoryArray = context.fetch(request)
//            
//        } catch {
//            
//            print("Error fetching context request \(error)")
//        }
//        
//        tableView.reloadData()
    }
    
    // TODO:- Add Color To Categories Methods
    
    func addColor(cell: UITableViewCell, at row: Int) {
        
        if let categoryHexColor = categories?[row].hexColor  {
            
            cell.backgroundColor = UIColor(hexString: categoryHexColor)
            
        } else {
            
            cell.backgroundColor = UIColor.randomFlat
            
            do {
                
                try realm.write {
                    
                    if let category = categories?[row] {
                            
                            category.hexColor = cell.backgroundColor?.hexValue()
                            
                            realm.add(category)
                    }
                }
                
            } catch {
                
                print("Error save hexColor \(error)")
            }
        }
        
        if let color = cell.backgroundColor {
            
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            
        }
    }

    //TODO:- Delete Categories From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {

            do {

                try self.realm.write {

                    self.realm.delete(category)

                }

            } catch {

                print("Error deleting category \(error)")
            }
        }
    }
    
    // MARK:- Add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //TODO:- Add Alert
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        //TODO:- Add Text Field Alert
        
        alert.addTextField { textFieldAlert in
            
            textFieldAlert.placeholder = "Create new category"
            
            textField = textFieldAlert
            
            
        }
        
        //TODO:- Add Action
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category()
            
            //print(textField.text)
            
            newCategory.name = textField.text!
            
//            self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        //TODO:- Show Alert
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Table View Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "goToItem", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToItem" {
            
            let destinationVC = segue.destination as! WhatNextController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                destinationVC.selectedCategory = categories?[indexPath.row]
                
            }
        }
        
    }
    
}


