//
//  ViewController.swift
//  db
//
//  Created by Mitosis on 22/02/17.
//  Copyright © 2017 Mitosis. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var TableView: UITableView!
    
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return people.count
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        let person = people[indexPath.row]
        cell.txtLabel.text = person.value(forKey: "name") as? String
        
        
        return cell
    }
    
  
    @IBAction func plus(_ sender: AnyObject) {
 
       
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.saveName(name: (textField?.text)!)
                                        self.TableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveName(name: String) {
      
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                 in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        
   
        person.setValue(name, forKey: "name")
        
    
        do {
            try managedContext.save()
          
            people.append(person)
      
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
       let managedObjectContext = appDelegate.persistentContainer.viewContext
        
     
        let  request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
    
        do {
            let results =
                try managedObjectContext.fetch(request)
            people = results as! [NSManagedObject]
         
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}

