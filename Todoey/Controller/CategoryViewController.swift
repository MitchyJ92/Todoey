//
//  CateogoryViewController.swift
//  Todoey
//
//  Created by Mitchell Johnstone on 2019-07-29.
//  Copyright © 2019 Mitchell Johnstone. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    
    
  
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadCategory()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        cell.accessoryType = .detailButton
        
        return cell
        
        

    }

    
    //MARK: Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
        
        
        

    

//MARK: - add new category

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
        //what will happen when the user clicks the add button on our UI alert
        
        
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
      
        
        self.categoryArray.append(newCategory)
        self.saveCategory()
        
        
        
        
        
    }
    alert.addTextField { (alertTextfield) in
        alertTextfield.placeholder = "Create New Category"
        textField = alertTextfield
    
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
}
    
    //MARK: Data manipulation methods
    
 func saveCategory()   {
    
    
    do {
    
    try context.save()
    
    
    } catch  {
    
    print("error saving context, \(error)")
    
    
    }
    
    tableView.reloadData()
    
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("error fetching data from context \(error)")
        }
        tableView.reloadData()
        
        
        
    }
    
}
