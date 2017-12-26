//
//  CategoryTableViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/26/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    // MARK:- Data Manipulation Methods
    
    
    
    // TODO:- Save Categories Methods
    
    func saveCategories() {
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    // TODO:- Load Categories Methods
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            
            try categoryArray = context.fetch(request)
            
        } catch {
            
            print("Error fetching context request \(error)")
        }
        
        tableView.reloadData()
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
            
            print("Successful")
            
        }
        
        //TODO:- Add Action
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category(context: self.context)
            
            //print(textField.text)
            
            newCategory.name = textField.text
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
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
                
                destinationVC.selectedCategory = categoryArray[indexPath.row]
                
            }
        }
        
    }
    
}