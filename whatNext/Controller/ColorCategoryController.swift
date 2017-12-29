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

class ColorCategoryController: SwipeTableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var colorBank : Results<CategoryChangeColor>?
    
    var bank : Results<CategoryChangeColor>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        
        didSet {
            
            loadColors()
            bank = colorBank
        }
    }

    let allColors = ColorBank()
    
    var selectedRow : Int?
    
    var firstSelected : Int?
    
    var checkSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendColors()
        
        //print(allColors.list.count)

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
        
        guard let navBar = navigationController?.navigationBar else {
            
            fatalError("Navigation Controller does not exist yet!")
        }
        
        searchBar.barTintColor = navBar.barTintColor
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return colorBank?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = colorBank?[indexPath.row].name
        
        cell.backgroundColor = UIColor(hexString: (colorBank?[indexPath.row].hexName)!)
        
        guard let backgroundColor = cell.backgroundColor else {
            
            fatalError("No Cell Exists")
        }
        
        cell.textLabel?.textColor = ContrastColorOf(backgroundColor, returnFlat: true)
        
        if let done = colorBank?[indexPath.row].done {
         
            cell.accessoryType = done ? .checkmark : .none
            
            if cell.accessoryType == .checkmark {
                    
                    checkSelected = indexPath.row
            }
            
        }
        
        return cell
    }
    
    //MARK: - Table Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(checkSelected)
        
        removeDone()
        
        if let newColor = colorBank?[indexPath.row] {
            
            do {
                
                try realm.write {
                    
                        //print(bank?[newColor.id].id)
                        
                        if let done = bank?[newColor.id].done {
                            
                            
                            if let selected = selectedRow {
                                
                                bank?[selected].done = false
                                
                            }
                            
                            selectedRow = newColor.id
                            
                            bank?[newColor.id].done = !done
                            
                        }
                }
                
            } catch {
                
                print("Error saving done status \(error)")
                
            }
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
       
        tableView.reloadData()
      
    }
    
    //MARK:- Back Tapped Method
    
    
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
        
        removeDone()
        
        do {
            
            try realm.write {
                
                if let selected = checkSelected {
                    
                    bank?[selected].done = false
                    
                    if let row = firstSelected {
                        
                        bank?[row].done = true
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
                    
                    selectedCategory?.hexColor = bank?[row].hexName
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
        
        //Sort Color ASC Alphabets
        
        allColors.list =  allColors.list.sorted(by: {$0.colorName < $1.colorName})
        
        for i in 0..<allColors.list.count {
            
            if let currentCategory = selectedCategory {
                
                do {
                    
                    try realm.write {
                        
                        let newColor = CategoryChangeColor()
                        
                        newColor.id = i
                  
                        newColor.name = allColors.list[i].colorName
                            
                        newColor.hexName = allColors.list[i].hexColor
     
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
    
    //TODO: - Remove Done
    
    func removeDone() {
        
        if let checkRow = checkSelected {
            
            letFalseDone(newColor: bank?[checkRow])
            
            letFalseDone(newColor: colorBank?[checkRow])
        }
        
    }
    
    func letFalseDone(newColor: CategoryChangeColor?) {
        
        do {
            
            try realm.write {
                
                newColor?.done = false
                
            }
            
        } catch {
            
            print("Error removing first done selected \(error)")
            
        }
    }
    
}

//MARK: - Search Bar Methods

extension ColorCategoryController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        colorBank = colorBank?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        
            tableView.reloadData()
        
        if let colors = colorBank {
            
            if colors.count == 0 {
                
                loadColors()
            } else {
                
                DispatchQueue.main.async {
                    
                    searchBar.resignFirstResponder()
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        loadColors()
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
            
            tableView.reloadData()
        }
    }
}

