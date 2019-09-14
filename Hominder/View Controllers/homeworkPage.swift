//
//  ViewController.swift
//  Hominder
//
//  Created by Apple on 30/08/19.
//  Copyright © 2019 Vasisht Muduganti. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit
class homeworkPage: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate{
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var homework:[Homework] = [Homework]()
    var newDay:String?
    var completedHomework:[Homework] = [Homework]()
    var tableDisplay:[Homework] = [Homework]()
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    var hi:Int = 9
    
    @IBAction func segmentAction(_ sender: Any) {
        if segmentController.selectedSegmentIndex == 0{
            let requested : NSFetchRequest<Homework> = Homework.fetchRequest()
            do{
                homework = try context.fetch(requested)
                homework = homework.reversed()
                tableDisplay = homework
                
                tableView.reloadData()
            }
            catch{
                print("this is an error \(error)")
            }
        }
        else if(segmentController.selectedSegmentIndex == 1){
            for i in completedHomework{
                print(i.subject)
                
                
                
            }
            tableDisplay = completedHomework
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //UserDefaults.standard.set(0, forKey:"dayNo")
        
        print("yeetle weetle eet")
        print("heyya fool")
        let requested : NSFetchRequest<Homework> = Homework.fetchRequest()
        do{
            homework = try context.fetch(requested)
            homework = homework.reversed()
            print(homework)
        }
        catch{
            print("this is an error \(error)")
        }
        /*for i in homework{
         do{
         try context.delete(i)
         }
         catch{
         print("error")
         }
         }
         */
        do{
            try self.context.save()
        }
        catch{
            print("error occurred")
        }
        homework = homework.reversed()
        tableDisplay = homework
        print("reloaded")
        let secondTab = self.tabBarController?.viewControllers?[1] as! newHomework
        secondTab.homework2 = self.homework
        //print(homework[0].day)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("hi")
        print("nerd")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeworkCell") as! homeworkCell
        cell.subject.text = tableDisplay[indexPath.row].subject
        cell.desc.text = tableDisplay[indexPath.row].desc
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default, title: "Done") { action, indexPath in
            // handle action by updating model with deletion
            self.completedHomework.append(self.homework[indexPath.row])
            
            
            do{
                try self.context.delete(self.homework[indexPath.row])
            }
            catch{
                print("error")
            }
            do{
                try self.context.save()
            }
            catch{
                print("error occurred")
            }
            
            self.tableDisplay = self.homework
            self.tableView.reloadData()
            
        }
        deleteAction.backgroundColor = UIColor(red:0/255, green:194/255, blue:0/255, alpha:1.0)
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableDisplay.count
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
}
}
