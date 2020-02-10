//
//  DetailCallingTableViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-22.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

protocol DetailCallingTableViewControllerDelegate: class {
    func  DetailCallingTableViewController(_ controller: DetailCallingTableViewController, didFinishEditting item: Plan, indexPath: IndexPath)
}

class DetailCallingTableViewController: UITableViewController {
    
    var callingCelllist = CallingCellList()
    var item = Plan()
    var indexPath = IndexPath()
    weak var delegate: DetailCallingTableViewControllerDelegate?

    var datePickerIndexPath: IndexPath?
    var inputDates:[Date] = []
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        assignImformationToCell(index: indexPath.row)
        
        addInitailValues()
//        showUpDatePicker()
        tableView.register(UINib(nibName: "DayPickerTableViewCell", bundle: nil), forCellReuseIdentifier: "dayPicker")
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
//        if datePickerIndexPath != nil {
//            return 8
//        }
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 1 && datePickerIndexPath != nil {
            return 2
        }
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if datePickerIndexPath == indexPath {
            let datePickerCell = (tableView.dequeueReusableCell(withIdentifier:   DayPickerTableViewCell.reuseIdentier()) as?  DayPickerTableViewCell)!
            datePickerCell.updateCell(date: inputDates[indexPath.section - 1], indexPath: indexPath)
            datePickerCell.delegate = self as DatePickerDelegate
            
            return datePickerCell
        }
        
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "NameCalling", for: indexPath) as? NameCallingForTableViewCell)!
            
            cell.NameCallingForLabel.text = item.nameCallingFor
            

            // Configure the cell...

            return cell
        }
        else if indexPath.section == 1 {
            
            
            let cell = (tableView.dequeueReusableCell(withIdentifier: "date Calling", for: indexPath) as? DateCallingTableViewCell)!
            cell.updateText(date: inputDates[indexPath.row])
            
            // Configure the cell...
            cell.DateCallingLabel.text = item.localDate
            return cell
            
            
            }
        else if indexPath.section == 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local Name", for: indexPath) as? LocalNameTableViewCell)!

            // Configure the cell...

            cell.localNameLabel.text = item.localName
            
            return cell
        }
        
        else if indexPath.section == 3 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local Time", for: indexPath) as? LocalTimeTableViewCell)!

            // Configure the cell...
            cell.LocalTimeLabel.text = item.localTime

            return cell
        }
        else if indexPath.section == 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination Name", for: indexPath) as? DestinationNameTableViewCell)!

            // Configure the cell...

            cell.DestinationNameLabel.text = item.destinationName
            return cell
        }
        else if indexPath.section == 5 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "jet Lag", for: indexPath) as? JetLagTableViewCell)!
 
            // Configure the cell...
            cell.jetLagLabel.text = item.jetLag

            return cell
        }
        else if indexPath.section == 6 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination Time", for: indexPath) as? DestinationTimeTableViewCell)!

            // Configure the cell...
            cell.destinationTimeLabel.text = item.destinationTime as? String

            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
    
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            tableView.beginUpdates()
            
             if let datePickerIndexPath = datePickerIndexPath,   datePickerIndexPath.row - 1 == indexPath.row {
               tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
               self.datePickerIndexPath = nil
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
    }
        
        
    @IBAction func back() {
           
        delegate?.DetailCallingTableViewController(self, didFinishEditting: item, indexPath: self.indexPath)
        navigationController?.popViewController(animated: true)

    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
       if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
       } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
       }
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
    
//    func showUpDatePicker()  {
//
//
//    }
    
    func addInitailValues() {
        inputDates = Array(repeating: Date(), count: 1)
    }
    
    //MARK: - BUTTON
    
    @IBAction func back() {
        delegate?.DetailCallingTableViewController(self, didFinishEditting: item, indexPath: self.indexPath)
        navigationController?.popViewController(animated: true)
    }

}

extension DetailCallingTableViewController: EditItemTableViewControllerDelegate {
    func editItemViewController(_ controller: EdittingDetailTableViewController, didFinishEditting item: Plan, original originalItem: Plan) {
        self.item = item
        appDelegate.saveContext()
        self.tableView.reloadData()
    }
    
   
    
//    func addValue(item: Plan) -> Plan {
//        let plan = Plan(entity: Plan.entity(), insertInto: context)
//        plan.nameCallingFor = item.nameCallingFor
//        plan.localDate = item.localDate
//        plan.localName = item.localName
//        plan.localTime = item.localTime
//        plan.destinationName = item.destinationName
//        plan.jetLag = item.jetLag
//        plan.destinationTime = item.destinationTime
//        plan.notification = item.notification
//        plan.placeCallingAt = item.placeCallingAt
//        
//        return plan
//        
//    }
    
}

extension DetailCallingTableViewController: nameCallingViewControllerDelegate {
    func editItemViewController(_ controller: nameCallingViewController, didFinishEditting item: callingCellItem) {
        self.item = item
        self.tableView.reloadData()
    }
}

extension DetailCallingTableViewController: LocalNameViewControllerDelegate {
     func editItemViewController(_ controller: LocalNameViewController, didFinishEditting item: callingCellItem) {
        self.item = item
        self.tableView.reloadData()
    }
}


extension DetailCallingTableViewController: DestinationNameViewControllerDelegate {
    func editItemViewController(_ controller: DestinationNameViewController, didFinishEditting item: callingCellItem) {
        self.item = item
        self.tableView.reloadData()
    }
    
}

extension DetailCallingTableViewController: DatePickerDelegate {
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        inputDates[indexPath.row] = date
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
