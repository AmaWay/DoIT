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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
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
        
        saveItems()
        
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
            self.saveItems()
            
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true , completion: nil)
    }
    
    
    // MARK: - Model Manupulation Method
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data  = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            self.tableView.reloadData()
        }
        catch {
            print("Error in codeing item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error in decodeing item array, \(error)")
            }
        }
    }
    
}



