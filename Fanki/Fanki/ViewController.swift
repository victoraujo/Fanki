//
//  ViewController.swift
//  Fanki
//
//  Created by Victor Vieira on 18/08/20.
//  Copyright © 2020 Victor Vieira. All rights reserved.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!
    
   public var models = [MyWords]()
    public var today = [MyWords]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound ], completionHandler: {sucess, error in
            if sucess{
                
            }
            else if error != nil {
                print("error error ")
            }
        })
    }
    
    @IBAction func didTapAdd(){
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: Date())
        let month = calendar.component(.month, from: Date())
        let year = calendar.component(.year, from: Date())
        var components1 = DateComponents()
        components1.day = day
        components1.month = month
        components1.year = year
        let data = addNumberOfDaysToDate(date: calendar.date(from: components1)!, count: 1)
        
        vc.title = "New Word"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { word, translation, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyWords(title: word, date: date, indentifier: translation)
                self.models.append(new)
                
                let calendar2 = Calendar.current
                let components = calendar2.dateComponents([Calendar.Component.day,Calendar.Component.month,Calendar.Component.year], from: new.date)
                
                let newDate = calendar2.date(from: components)
                //let todayte = addNumberOfDaysToDate(date: <#T##Date#>, count: <#T##Int#>)
                
                if(newDate!<data){
                    self.today.append(new)
                }
                self.table.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = "Try to remember yours words"
                content.sound = .default
                content.body = word
                
                let targetDate = date 
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                
                let request = UNNotificationRequest(identifier: "umId", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    if error != nil{
                        print("deu erro")
                    }
                })
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapTest(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound ], completionHandler: {sucess, error in
//            if sucess{
//
//            }
//            else if let error = error{
//                print("error error ")
//            }
//        })
        let content = UNMutableNotificationContent()
        content.title = "fanki"
        content.sound = .default
        content.body = "Come to see your today's words"
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "umId", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil{
                print("deu erro")
            }
        })
    
    }

    
    @IBAction func didTapStart(){
//        let calendar = Calendar.current
//        print(calendar.component(.day, from: Date()))
//        print(calendar.component(.month, from: Date()))
//        print(calendar.component(.year, from: Date()))
        if models.count>0{
            
            
            
            guard let vc = storyboard?.instantiateViewController(identifier: "start") as? StartViewController else {
                return
            }
            //startView.modalPresentationStyle = .fullScreen
            //        vc.wordText.text = "Pegou!"
            //vc.setText(models[0].title)
            
//            vc.completion = { word, translation, date in
//            DispatchQueue.main.async {
            
            
            
            vc.setModel(today)
//            vc.completion = {dale in
//                DispatchQueue.main.async {
////                    self.present(vc, animated: true, completion: nil)
//                    //self.navigationController?.pushViewController(vc, animated: true)
//                    self.navigationController?.popToRootViewController(animated: true)
//                    self.today = dale
//                }
//            }
//            vc.condc = true
            //DispatchQueue.main.async{
            self.present(vc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
            //}
            //while(vc.condc){}
            today = vc.models
            print(vc.models.count)
            table.reloadData()
        }
    }
    
    
    
    let startView = StartViewController()
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return today.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = today[indexPath.row].title
        
        let date = today[indexPath.row].date
        //let newDate = addNumberOfDaysToDate(date: date, count: 20)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYY"
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    

}


struct MyWords {
    let title: String
    let date: Date
    let indentifier: String
}


func addNumberOfDaysToDate(date: Date, count: Int) -> Date{
    let newComponent = DateComponents(day: count)
    guard let newDate = Calendar.current.date(byAdding: newComponent, to: date) else {
        return date
    }
    return newDate
}
