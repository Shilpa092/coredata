//
//  ViewController.swift
//  coredataDemo
//
//  Created by Admin on 14/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Person]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        fetchPeople()
    }
        
        func  fetchPeople() {
            do {
                self.items = try context.fetch(Person.fetchRequest())
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                
            }
            
    }


    @IBAction func addTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "add person", message: "what is their name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitbutton = UIAlertAction(title: "add", style: .default) { (action) in
            let textfield = alert.textFields![0]
              //create aperson object
            let newperson = Person(context: self.context)
            newperson.name = textfield.text
            newperson.age = 20
            newperson.gender = "male"
            
            
            //save the data
            do {
                try self.context.save()
        }
            catch {
                
            }
            
            self.fetchPeople()
        }
        
        alert.addAction(submitbutton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personcell", for: indexPath)
        let person  = self.items![indexPath.row]
        cell.textLabel?.text = person.name
           return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.items![indexPath.row]
        
        let alert = UIAlertController(title: "edit person", message: "edit name", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = person.name
        
        let saveButton = UIAlertAction(title: "save", style: .default) { (action) in
            let textfield  = alert.textFields![0]
            
            
            person.name = textfield.text
            
            do {
                try self.context.save()
                
            }
            catch {
            
            
        }
            self.fetchPeople()
        }
        
        
        
        alert.addAction(saveButton)
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //swife action
        let action = UIContextualAction(style: .destructive, title: "delete") { (action, view, CompletionHandler) in
            let personToRemove = self.items![indexPath.row]
            self.context.delete(personToRemove)
            do {
                try self.context.save()
            }
            catch {
                
            }
            self.fetchPeople()
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

















