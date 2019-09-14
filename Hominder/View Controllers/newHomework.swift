//
//  newHomework.swift
//  Hominder
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Vasisht Muduganti. All rights reserved.
//

import UIKit
import CoreData
class newHomework: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate{
    var homework2: [Homework] = [Homework]()
    var subjectChosen: String = ""
    var value = "2"
    var dayNo:Int = 0
    @IBOutlet weak var newDay: UISwitch!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var newDayVar:String?
    @IBOutlet weak var createHW: UIButton!
    @IBOutlet var contentz: UIView!
    @IBOutlet weak var desField: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    
    @IBAction func createHWAction(_ sender: Any) {
        if(desField.text != ""){
            if(newDay.isOn == true){
                dayNo = UserDefaults.standard.integer(forKey: "dayNo")
                dayNo+=1
                UserDefaults.standard.set(dayNo, forKey: "dayNo")
            }
            let newHomework:Homework = Homework(context: self.context)
            newHomework.day = Int32(UserDefaults.standard.integer(forKey: "dayNo"))
            newHomework.desc = desField.text
            newHomework.subject = subjectChosen
            print("DAY NUMBER \(newHomework.day)")
            do{
                try self.context.save()
            }
            catch{
                print("error occurred")
            }
            let firstTab = self.tabBarController?.viewControllers?[0] as! ViewController
            homework2.insert(newHomework, at: 0)
            firstTab.homework = self.homework2
            firstTab.tableDisplay = firstTab.homework
            firstTab.tableView.reloadData()
            
            self.tabBarController?.selectedIndex = 0
        }
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        newDay.isOn = false
        print(value)
        desField.layer.cornerRadius = 7
        desField.layer.borderColor = UIColor.init(red: 50/255, green: 205/255, blue: 50/255, alpha: 1.0).cgColor
        desField.layer.borderWidth = 6.0
        
        createHW.layer.cornerRadius = 7
        createHW.layer.borderColor = UIColor.init(red: 135/255, green: 206/255, blue: 255/255, alpha: 1.0).cgColor
        createHW.layer.borderWidth = 2.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        subjectChosen = subjects[0]
        print(subjectChosen)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        desField.text = ""
        newDay.isOn = false
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    var subjects = ["Math", "Biology", "World Geography", "English", "Spanish"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subjectChosen = subjects[row]
        print(subjectChosen)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
   
}
