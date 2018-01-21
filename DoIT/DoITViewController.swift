//
//  DoITViewController.swift
//  DoIT
//
//  Created by Izabela on 21/01/2018.
//  Copyright © 2018 AmaWay. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController {

    let itemArray = ["Find Mike","Learn Swift","Go to Tuscany"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - TableView Data Source Methods

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoITCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

// MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if   tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
                tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
