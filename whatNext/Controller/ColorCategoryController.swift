//
//  ColorCategoryController.swift
//  whatNext
//
//  Created by HAI DANG on 12/28/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ColorCategoryController: SwipeTableViewController {
    
    var colorBank : Results<CategoryChangeColor>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        
        didSet {
            
            loadColors()
            
        }
    }

    let allColors = ColorBank()
    
    var selectedRow : Int?
    
    var firstSelected : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(selectedCategory?.hexColor)
        appendColors()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let colors = colorBank {
            
            for i in 0..<colors.count {
                
                if colors[i].done {
                    
                    firstSelected = i
                    
                    break
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allColors.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = colorBank?[indexPath.row].name
        
        cell.backgroundColor = allColors.list[indexPath.row].color
        
        guard let backgroundColor = cell.backgroundColor else {
            
            fatalError("No Cell Exists")
        }
        
        cell.textLabel?.textColor = ContrastColorOf(backgroundColor, returnFlat: true)
        
        if let done = colorBank?[indexPath.row].done {
         
            cell.accessoryType = done ? .checkmark : .none
            
            if cell.accessoryType == .checkmark {
                
                selectedRow = indexPath.row
                
            }
            
        }
        
        return cell
    }
    
    //MARK: - Table Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let newColor = colorBank?[indexPath.row] {
            
            do {
                
                try realm.write {
                    if let selected = selectedRow {
                        
                        if let done = colorBank?[selected].done {
                            
                            colorBank?[selected].done = !done
            
                        }
                        
                    }
                    
                    newColor.done = !newColor.done
  
                }
                
            } catch {
                
                print("Error saving done status \(error)")
                
            }
            
        }
        
        selectedRow = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
       
        tableView.reloadData()
      
    }
    
    //MARK:- Back Tapped Method
    
    
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
        
        do {
            
            try realm.write {
                
                if let selected = selectedRow {
                    
                    colorBank?[selected].done = false
                    
                    if let row = firstSelected {
                        
                        colorBank?[row].done = true
                    }
                }
            }
            
        } catch {
            
            print("Error saving new color \(error)")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK:- Done Tapped Method
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        
        //print("Done Tapped")
        
        do {
            
            try realm.write {
                
                if let row = selectedRow {
                    
                    selectedCategory?.hexColor = allColors.list[row].hexColor
                }
            }
            
        } catch {
            
            print("Error saving new color \(error)")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - Data Manipulation Methods
    
    //TODO: - Load Colors
    
    func loadColors() {
        
        colorBank = selectedCategory?.colors.sorted(byKeyPath: "id", ascending: true)
        
    }
    
    //TODO: - Append Colors
    
    func appendColors() {
        
        for i in 0..<allColors.list.count {
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    
                    try realm.write {
                        
                        let newColor = CategoryChangeColor()
                        
                        newColor.id = i
                        
                        newColor.name = allColors.list[i].colorName
                        
                        newColor.parentName = currentCategory.name
                        
                        if (selectedCategory?.colors.count)! < allColors.list.count {
                            
                            currentCategory.colors.append(newColor)
                        }
               
                    }
                    
                } catch {
                    
                    print("Error adding new colors \(error)")
                }
                
            }
        }
            
        }
}
