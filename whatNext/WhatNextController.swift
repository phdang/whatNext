//
//  ViewController.swift
//  whatNext
//
//  Created by HAI DANG on 12/25/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import UIKit

class WhatNextController: UITableViewController {

    let itemArray = ["PHP Session", "PHP Cookie", "Swift CoreData", "Swift Singleton"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    


}

