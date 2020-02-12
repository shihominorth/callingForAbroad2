//
//  NotificationViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-12.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit


protocol NotificationViewControllerDelegate : class {
    func editItemViewController(_ controller: NotificationViewController, didFinishEditting item: Plan)
}

class NotificationViewController: UIViewController {
    var item = Plan()
    var indexPath = IndexPath()
    
    
    let notifications: [Int] = [0, 5, 10, 30, 45, 60, 360,]
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:NotificationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NotificationViewController: UITableViewDelegate {

}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  notifications.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "pick up time") as? PickNotificationTimeTableViewCell)!
        
        
        switch indexPath.row {
        
        case 0, 1, 2, 3 ,4, 5, 6:
            cell.timeLabel.text = String(notifications[indexPath.row])
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        let cell = (tableView.cellForRow(at: indexPath) as? PickNotificationTimeTableViewCell)!
        
        item.notification = cell.timeLabel.text
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.editItemViewController(self, didFinishEditting: item)
        navigationController?.popViewController(animated: true)
        
    }
    
   
}

