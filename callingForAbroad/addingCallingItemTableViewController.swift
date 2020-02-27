//
//  addingCallingItemTableViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-18.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemTableViewControllerDidCancel(_ controller: addingCallingItemTableViewController)
    func addItemViewController(_ controller: addingCallingItemTableViewController, didFinishAdding item: callingCellItem)
}

class addingCallingItemTableViewController: UITableViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //lazy var plan = Plan(entity: Plan.entity(), insertInto: context)
    var item = callingCellItem()
    
    var planDelegate = PlanDelegate()
    weak var delegate: AddItemTableViewControllerDelegate?
    var datePickerIndexPath: IndexPath?
    var inputDates:[Date] = []
    var isFirstOpenDatePicker = false
    var isFirstDateValuePassed: Bool?
    var isEditting: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        addInitailValues()
        tableView.register(DayPickerTableViewCell.self, forCellReuseIdentifier: "datePicker")
    }
    
    func addInitailValues() {
        inputDates = Array(repeating: Date(), count: 3)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        if section == 1 && datePickerIndexPath?.section == 1 && isFirstOpenDatePicker == false {
            isFirstOpenDatePicker = true
            return 2
        }
        else if section == 3 && datePickerIndexPath?.section == 3 && isFirstOpenDatePicker == false{
            isFirstOpenDatePicker = true
            return 2
        }
        else if  section == 6 && datePickerIndexPath?.section == 6 && isFirstOpenDatePicker == false {
            isFirstOpenDatePicker = true
            return 2
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: "datePicker") as!  DayPickerTableViewCell
            
            switch datePickerIndexPath?.section {
            case 1:
                datePickerCell.updateCell(date: inputDates[0], indexPath: indexPath)
            case 3:
                datePickerCell.updateCell(date: inputDates[1], indexPath: indexPath)
            case 6:
                datePickerCell.updateCell(date: inputDates[2], indexPath: indexPath)
            default:
                break
            }
            
            datePickerCell.delegate = self as! DatePickerDelegate
            
            
            switch datePickerIndexPath?.section {
            case 1:
                datePickerCell.datePicker.datePickerMode = .date
            case 3:
                datePickerCell.datePicker.datePickerMode = .time
            case 6:
                datePickerCell.datePicker.datePickerMode = .dateAndTime
                
            default:
                break
            }
            
            return datePickerCell
        }
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "name calling for", for: indexPath) as? NameCallingForAddingTableViewCell )!
            
            cell.label.text = item.nameCallingFor
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local date", for: indexPath) as? LocalDateAddingTableViewCell)!
            
            if isFirstDateValuePassed == true {
                cell.label.text = item.localDate
            } else {
                cell.updateText(date: inputDates[0])
                item.localDate = cell.giveText(date: inputDates[0])
            }
            
            return cell
        }
            
        else if indexPath.section == 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local name", for: indexPath) as? LocalNameAddingTableViewCell)!
            
            cell.label.text = item.localName
            
            return cell
        }
        else if indexPath.section == 3 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local time", for: indexPath) as? LocalTimeAddingTableViewCell)!
            
            if isFirstDateValuePassed == true {
                cell.label.text = item.localTime
            } else {
                cell.updateText(date: inputDates[1])
                item.localTime = cell.giveText(date: inputDates[1])
            }
            
        
            return cell
        }
        else if indexPath.section == 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination name", for: indexPath) as? DestinationNameAddingTableViewCell)!
            
            cell.label.text = item.destinationName
            
            return cell
        }
        else if indexPath.section == 5 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "jet lag", for: indexPath) as? JetLagAddingTableViewCell)!
            
            cell.label.text = item.jetLag
            
            return cell
        }
        else if indexPath.section == 6 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination time", for: indexPath) as? DestinationTimeAddingTableViewCell)!
            
            if isFirstDateValuePassed == true {
                cell.label.text = item.destinationTime
            } else {
                cell.updateText(date: inputDates[2])
                item.destinationTime = cell.giveText(date: inputDates[2])
            }
            
            
            return cell
        }
        else if indexPath.section == 7 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as? NotificationTimeAddingTableViewCell)!
            
            cell.label.text = item.notification
            
            return cell
        }
        else if indexPath.section == 8 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "place calling at", for: indexPath) as? PlaceCallingAtAddingTableViewCell)!
            
            cell.label.text = item.placeCallingAt
            
            return cell
        }
        else if indexPath.section == 9
        {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "map", for: indexPath) as? MapPlaceCallingAtTableViewCell)!
            
            return cell
        }
        
        return UITableViewCell()
        
        
        
    }
    
    @IBAction func add(_ sender: Any) {
        
        let homeVC = storyboard?.instantiateViewController(identifier: "home") as! callinglistViewController
        
        
        
//        if let indexPath:IndexPath = IndexPath(row: 0, section: 0) {
//            let cell = (tableView.cellForRow(at: indexPath) as? NameCallingForAddingTableViewCell)!
//            item.nameCallingFor = cell.label.text!
//        }
//        if let indexPath:IndexPath = IndexPath(row: 0, section: 1) {
//            let cell = (tableView.cellForRow(at: indexPath) as? LocalTimeAddingTableViewCell)!
//            item.localName = cell.label.text!
//        }
        
//        if let indexPath:IndexPath = IndexPath(row: 0, section: 2) {
//            let cell = (tableView.cellForRow(at: indexPath) as? LocalDateAddingTableViewCell)!
//            item.localDate = cell.label.text! ?? ""
//        }
//        if let indexPath: IndexPath = IndexPath(row: 0, section: 3) {
//            let cell = (tableView.cellForRow(at: indexPath) as? LocalTimeAddingTableViewCell)!
//            item.localTime = cell.label.text! ?? ""
//        }
////        if let indexPath: IndexPath = IndexPath(row: 0, section: 4) {
////            let cell = (tableView.cellForRow(at: indexPath) as? DestinationNameAddingTableViewCell)!
////            item.destinationName = cell.label.text! ?? ""
////        }
//        if let indexPath: IndexPath = IndexPath(row: 0, section: 5) {
//            let cell = (tableView.cellForRow(at: indexPath) as? JetLagAddingTableViewCell)!
//            item.jetLag = cell.label.text! ?? ""
//        }
//        if let indexPath: IndexPath = IndexPath(row: 0, section: 6) {
//            let cell = (tableView.cellForRow(at: indexPath) as? DestinationTimeAddingTableViewCell)!
//            item.destinationTime = cell.label.text! ?? ""
//        }
//        if let indexPath:IndexPath = IndexPath(row: 0, section: 7) {
//            let cell = (tableView.cellForRow(at: indexPath) as? NotificationTimeAddingTableViewCell)!
//            item.notification = cell.label.text! ?? ""
//        }
//        if let indexPath: IndexPath = IndexPath(row: 0, section: 8) {
//            let cell = (tableView.cellForRow(at: indexPath) as? PlaceCallingAtAddingTableViewCell)!
//            item.placeCallingAt = cell.label.text!
//        }
//        
        
        delegate?.addItemViewController(self, didFinishAdding: item)
        navigationController?.popViewController(animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 6 {
            
            tableView.beginUpdates()
            
            if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
                
                tableView.reloadRows(at: [indexPath], with: .none)
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                self.datePickerIndexPath = nil
                isFirstOpenDatePicker = false
                
            } else {
                // 2
                if let datePickerIndexPath = datePickerIndexPath {
                    tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                }
                
                datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
                tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
                tableView.deselectRow(at: indexPath, animated: true)
                

            }
            tableView.endUpdates()
            
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch indexPath.row {
        case 1:
            if datePickerIndexPath?.section == 1 {
                return 150.0
            }
            else if datePickerIndexPath?.section == 3 {
                return 150.0
            }
            else if datePickerIndexPath?.section == 6 {
                return 150.0
            }
            
        default:
            break
        }
        
        
        return UITableView.automaticDimension
    }
    
    //
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addingNameCallingFor" {
            if let edittingVC = segue.destination as? nameCallingViewController {
                edittingVC.isAdding = true
                 edittingVC.text = item.nameCallingFor
                edittingVC.delegate2 = self as nameCallingViewControllerDelegate2
            }
        }
        
        //         if segue.identifier == "addingNameCallingFor" {
        //                    if let edittingVC = segue.destination as? nameCallingViewController {
        //                        edittingVC.item = self.plan
        //        //                edittingVC.delegate = self as! nameCallingViewControllerDelegate
        //                    }
        //                }
        
        if segue.identifier == "addingLocalName" {
            if let edittingVC = segue.destination as? LocalNameViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.localName
                edittingVC.delegate2 = self as LocalNameViewControllerDelegate2
            }
        }
        
        if segue.identifier == "addingDestinationName" {
            if let edittingVC = segue.destination as? DestinationNameViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.destinationName
                edittingVC.delegate2 = self as DestinationNameViewControllerDelegate2
                //                edittingVC.delegate = self as! nameCallingViewControllerDelegate
            }
        }
        
        if segue.identifier == "addingNotification" {
            if let edittingVC = segue.destination as? NotificationViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.destinationName
                edittingVC.delegate2 = self as? NotificationViewControllerDelegate2
                
                //                edittingVC.delegate = self as! nameCallingViewControllerDelegate
            }
        }
        
        if segue.identifier == "addingplacecallingat" {
            if let edittingVC = segue.destination as? PlaceCallingAtViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.placeCallingAt
                edittingVC.delegate2 = self as? PlaceCallingAtViewControllerDelegate2
            }
        }
    }
    
    
    // MARK: - Core data
    
}

extension addingCallingItemTableViewController: DatePickerDelegate {
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        
        self.isFirstDateValuePassed = false
        
        switch indexPath.section {
        case 1:
            inputDates[0] = date
        case 3:
            inputDates[1] = date
        case 6:
            inputDates[2] = date
        default:
            break
        }
        
    }
    
}

extension addingCallingItemTableViewController: nameCallingViewControllerDelegate2 {
    func editItemViewController(_ controller: nameCallingViewController, nameCallFor: String) {
        self.item.nameCallingFor = nameCallFor
        tableView.reloadData()
    }
    
}


extension addingCallingItemTableViewController: LocalNameViewControllerDelegate2 {
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting localName: String!) {
        self.item.localName = localName
        tableView.reloadData()
    }
    
}


extension addingCallingItemTableViewController: DestinationNameViewControllerDelegate2 {
    func editItemViewController(_ controller: DestinationNameViewController, destinationName: String) {
        self.item.destinationName = destinationName
        tableView.reloadData()
    }
    
}

extension addingCallingItemTableViewController: NotificationViewControllerDelegate2 {
    func editItemViewController(_ controller: NotificationViewController, didFinishEditting notification: String) {
        self.item.notification = notification
        tableView.reloadData()
    }
    
}

extension addingCallingItemTableViewController: PlaceCallingAtViewControllerDelegate2 {
    func editItemViewController(_ controller: PlaceCallingAtViewController, didFinishEditting placeCallingAt: String) {
        self.item.placeCallingAt = placeCallingAt
        tableView.reloadData()
    }
    
}



