//
//  ViewController.swift
//  ToDoey
//
//  Created by Roland Christensen on 2/26/18.
//  Copyright © 2018 Roland Christensen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemsArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemsArray.append(newItem)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemsArray = items
        }
        
    }

    //MARK - Tableview Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
         return cell
    }
        
        
// The lines below are the way to write the ternary operator above using an if/else statement
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//        return cell
//    }
//
    
    
    //MARK - TableView Delegate Method
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
       let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on UI Button alert
            print("Success!")
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemsArray.append(newItem)
            
            self.defaults.set(self.itemsArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

  }
