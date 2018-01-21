//
//  DoITViewController.swift
//  DoIT
//
//  Created by Izabela on 21/01/2018.
//  Copyright © 2018 AmaWay. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Practice Japanese"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem.title = "Learn Spanish"
        itemArray.append(newItem2)
          
        if let items = defaults.array(forKey: "DoITListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    
    // MARK: - TableView Data Source Methods
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoITCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.completed ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].completed = !itemArray[indexPath.row].completed
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newItemText = UITextField()
        
        let alert = UIAlertController(title: "Add New DoIT Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //What will happen once the user clicks the Add Item button on UIAlert
            
            let newItem = Item()
            newItem.title = newItemText.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "DoITListArray")
            self.tableView.reloadData()
            
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true , completion: nil)
    }
    
}



