//
//  DetailCallingTableViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-22.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

protocol DetailCallingTableViewControllerDelegate: class {
    //    func  DetailCallingTableViewController(_ controller: DetailCallingTableViewController, didFinishEditting item: callingCellItem, indexPath: IndexPath)
    
    func  DetailCallingTableViewController(_ controller: DetailCallingTableViewController, didFinishEditting item: Plan, indexPath: IndexPath)
    
    func DetailCallingTableViewController(_ controller: DetailCallingTableViewController, addNewItem item: Plan, indexPath: IndexPath)
}

class DetailCallingTableViewController: UITableViewController {
    
    var callingCelllist = CallingCellList()
    //    var item = callingCellItem()
    var item = Plan()
    var indexPath = IndexPath()
    weak var delegate: DetailCallingTableViewControllerDelegate?
    
    var datePickerIndexPath: IndexPath?
    //var inputDates:[Date] = []
    var inputDates = Date()
    
    var isFirstOpenDatePicker = false
    var isFirstDateValuePassed: Bool?
    var isEditting: Bool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //        assignImformationToCell(index: indexPath.row)
        
        //addInitailValues()
        //        showUpDatePicker()
        tableView.tableFooterView = UIView()
        tableView.register(DayPickerTableViewCell.self, forCellReuseIdentifier: "datePicker")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editting Segue" {
            if let edittingVC = segue.destination as? EdittingDetailTableViewController {
                edittingVC.editItem = self.item
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self
            }
        }
        
        if segue.identifier == "edittingNameCallingFor" {
            if let edittingVC = segue.destination as? nameCallingViewController {
                edittingVC.item = self.item
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self
            }
        }
        if segue.identifier == "edittingLocalName" {
            if let edittingVC = segue.destination as? LocalNameViewController {
                edittingVC.item = self.item
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self
            }
        }
        if segue.identifier == "edittingDestinationName" {
            if let edittingVC = segue.destination as? DestinationNameViewController {
                edittingVC.item = self.item
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self
            }
        }
        
        if segue.identifier == "edittingNotification" {
            if let edittingVC = segue.destination as? NotificationViewController {
                edittingVC.item = self.item
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self as NotificationViewControllerDelegate
            }
        }
        
        if segue.identifier == "editting place calling at" {
            if let edittingVC = segue.destination as? PlaceCallingAtViewController {
                edittingVC.item = self.item
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self as PlaceCallingAtViewControllerDelegate
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //        if datePickerIndexPath != nil {
        //            return 8
        //        }
        return 9
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
            datePickerCell.indexPath = indexPath
            
            switch datePickerIndexPath?.section {
            case 1:
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (item.localName!)) ?? TimeZone.current
                print(datePickerCell.datePicker.timeZone!)
                //                datePickerCell.datePicker.setDate(inputDates, animated: true)
                //                datePickerCell.updateCell(date: inputDates, indexPath: indexPath)
                
                datePickerCell.datePicker.setDate(item.localDate!, animated: true)
            //                datePickerCell.updateCell(date: item.localDate!, indexPath: indexPath)
            case 3:
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (item.localName!)) ?? TimeZone.current
                print(datePickerCell.datePicker.timeZone!)
                //                datePickerCell.datePicker.setDate(inputDates, animated: true)
                //                datePickerCell.updateCell(date: inputDates, indexPath: indexPath)
                datePickerCell.datePicker.setDate(item.localDate!, animated: true)
            //                datePickerCell.updateCell(date: item.localDate!, indexPath: indexPath)
            case 6:
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (item.destinationName!)) ?? TimeZone.current
                print(datePickerCell.datePicker.timeZone!)
                //                datePickerCell.datePicker.setDate(inputDates, animated: true)
                //                datePickerCell.updateCell(date: inputDates, indexPath: indexPath)
                datePickerCell.datePicker.setDate(item.localDate!, animated: true)
            //                datePickerCell.updateCell(date: item.destinationTime!, indexPath: indexPath)
            default:
                break
            }
            
            datePickerCell.delegate = self
            
            
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
            let cell = (tableView.dequeueReusableCell(withIdentifier: "NameCalling", for: indexPath) as? NameCallingForTableViewCell)!
            
            cell.NameCallingForLabel.text = item.nameCallingFor ?? ""
            
            
            // Configure the cell...
            
            return cell
        }
        else if indexPath.section == 1 {
            
            
            let cell = (tableView.dequeueReusableCell(withIdentifier: "date Calling", for: indexPath) as? DateCallingTableViewCell)!
            
            
            // Configure the cell...
            if isFirstDateValuePassed == true {
                cell.DateCallingLabel.text = item.localDate?.convertToString(dateformat: .date, timeZoneIdentifier: item.localName!) ?? "None"
                
            } else {
                //                cell.DateCallingLabel.text = item.localDate?.convertToString(dateformat: .date, timeZoneIdentifier: item.localName!) ?? "None"
                cell.updateText(date: item.localDate!, timeZoneIdentifier: item.localName ?? TimeZone.current.identifier, indexNumber: 0)
               
            }
            return cell
            
            
        }
        else if indexPath.section == 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local Name", for: indexPath) as? LocalNameTableViewCell)!
            
            // Configure the cell...
            
            
            cell.localNameLabel.text = item.localName ?? "None"
            
            return cell
        }
            
        else if indexPath.section == 3 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local Time", for: indexPath) as? LocalTimeTableViewCell)!
            
            // Configure the cell...
            
            if isFirstDateValuePassed == true {
                cell.LocalTimeLabel.text = item.localDate?.convertToString(dateformat: .time, timeZoneIdentifier: item.localName!) ?? "None"
                
            } else {
                //                cell.updateText(date: inputDates, timeZoneIdentifier: item.localName ?? TimeZone.current.identifier, indexNumber: 1)
                cell.updateText(date: item.localDate!, timeZoneIdentifier: item.localName ?? TimeZone.current.identifier, indexNumber: 1)
                //                item.localDate = cell.LocalTimeLabel.text?.convertStringToDate(dateformat: .dateWithTime, timeZoneIdentifier: item.localName!)
               
            }
            
            return cell
        }
        else if indexPath.section == 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination Name", for: indexPath) as? DestinationNameTableViewCell)!
            
            // Configure the cell...
            
            cell.DestinationNameLabel.text = item.destinationName ?? "None"
            return cell
        }
        else if indexPath.section == 5 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "jet Lag", for: indexPath) as? JetLagTableViewCell)!
            
            // Configure the cell...
            let getTimeDifference = GetTimeDifference(localName: item.localName, destinationName: item.destinationName, date: nil)
            
            item.jetLag = getTimeDifference.timeDifferenceWithCityNames()
            cell.jetLagLabel.text = item.jetLag ?? "None"
            
            return cell
        }
        else if indexPath.section == 6 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination Time", for: indexPath) as? DestinationTimeTableViewCell)!
            
            
            // Configure the cell...
            
            if isFirstDateValuePassed == true {
                cell.destinationTimeLabel.text = item.destinationTime?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: item.destinationName ?? TimeZone.current.identifier)
                
            } else {
                cell.updateText(date: inputDates, timeZoneIdentifier: item.destinationName ?? TimeZone.current.identifier, indexNumber: 2)
                //                item.destinationTime = cell.destinationTimeLabel.text
                
               
            }
            
            return cell
        }
            
        else if indexPath.section == 7 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as? NotificaitonTableViewCell)!
            
            cell.label.text = String(item.notification!) 
            
            return cell
        }
        else if indexPath.section == 8 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "detail place calling at ", for: indexPath) as? DetailPlaceCallingAtTableViewCell)!
            
            cell.label.text = item.placeCallingAt ?? "None"
            
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
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
            
            if let datePickerIndexPath = datePickerIndexPath, let datePickerCell = (tableView.cellForRow(at: datePickerIndexPath) as? DayPickerTableViewCell) {
                
                switch datePickerIndexPath.section {
                case 1, 3:
                    
                    datePickerCell.datePicker.setDate(item.localDate!, animated: true)
                    
                case 6:
                    
                    datePickerCell.datePicker.setDate(item.destinationTime!, animated: true)
                    
                default:
                    break
                }
                
                tableView.deselectRow(at: indexPath, animated: true)
                
            }
        }
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
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: - BUTTON
    
    @IBAction func back() {
        
        delegate?.DetailCallingTableViewController(self, didFinishEditting: item, indexPath: self.indexPath)
        navigationController?.popViewController(animated: true)
    }
}


// MARK: Extensions


extension DetailCallingTableViewController: EditItemTableViewControllerDelegate {
    
}

extension DetailCallingTableViewController: nameCallingViewControllerDelegate {
    func editItemViewController(_ controller: nameCallingViewController, didFinishEditting item: Plan) {
        self.item = item
        
        self.tableView.reloadData()
    }
}

extension DetailCallingTableViewController: LocalNameViewControllerDelegate {
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting item: Plan) {
        self.item = item
       
        self.tableView.reloadData()
    }
}


extension DetailCallingTableViewController: DestinationNameViewControllerDelegate {
    
    func editItemViewController(_ controller: DestinationNameViewController, didFinishEditting item: Plan) {
        self.item = item
        
        self.tableView.reloadData()
    }
    
}

extension DetailCallingTableViewController: NotificationViewControllerDelegate {
    func editItemViewController(_ controller: NotificationViewController, didFinishEditting item: Plan) {
        self.item = item
        
        self.tableView.reloadData()
    }
    
}

extension DetailCallingTableViewController: PlaceCallingAtViewControllerDelegate {
    func editItemViewController(_ controller: PlaceCallingAtViewController, didFinishEditting item: Plan) {
        self.item = item
        
        self.tableView.reloadData()
    }
    
}


extension DetailCallingTableViewController: DatePickerDelegate {
    
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        
       
        self.isFirstDateValuePassed = false
        inputDates = date
        
        
        switch indexPath.section {
        case 1, 3:
            
            item.localDate = date
            item.destinationTime = date
            
             let getTimeDifference = GetTimeDifference(localName: item.localName, destinationName: item.destinationName, date: nil)
             item.jetLag = getTimeDifference.timeDifferenceWithCityNames()
            
        case 6:
            
            item.localDate = date
            item.destinationTime = date
            
             let getTimeDifference = GetTimeDifference(localName: item.localName, destinationName: item.destinationName, date: nil)
             item.jetLag = getTimeDifference.timeDifferenceWithCityNames()
            
        default:
            break
        }
    }
    
}

