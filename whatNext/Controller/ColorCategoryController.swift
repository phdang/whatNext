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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(selectedCategory?.hexColor)
        appendColors()
       
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
        
        
        return cell
    }
    
    //MARK: - Table Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let color = colorBank?[indexPath.row] {
            
            do {
                
                try realm.write {
                    
                    
                    color.done = !color.done
                    
                }
                
            } catch {
                
                print("Error saving done status \(error)")
                
            }
            
            guard let cell = tableView.cellForRow(at: indexPath) else {
                
                fatalError("No cell at this indexPath")
                
            }
            
            cell.accessoryType = color.done ? .checkmark : .none
            
        }
        
        selectedRow = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
       
        tableView.reloadData()
      
    }
    
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        
        print("Done Tapped")
        
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
        
        colorBank = selectedCategory?.colors.sorted(byKeyPath: "name", ascending: true)
        
    }
    
    //TODO: - Append Colors
    
    func appendColors() {
        
        for i in 0..<allColors.list.count {
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    
                    try realm.write {
                        
                        let newColor = CategoryChangeColor()
                        
                        newColor.name = allColors.list[i].colorName
                        
                        currentCategory.colors.append(newColor)
                        
                    }
                    
                } catch {
                    
                    print("Error adding new colors \(error)")
                }
                
            }
        }
            
        }
        
        
    
}
