//
//  ViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-07.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class callinglistViewController: UITableViewController {
    
    let callingCelllist = CallingCellList()
//    let planDelegate = PlanDelegate()
//    var section1: Dictionary = [String:NSMutableArray]()
//    var section2: Dictionary = [String:NSMutableArray]()
//    var sections: Array = [Dictionary<String,NSMutableArray>]()
    
    let dataManager = DataManager()
    var delegate: DataManagerDelegate?
    
    private var plans:[Plan]? = []
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataManager.delegate = self
        dataManager.getData()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.tableFooterView = UIView()
        
        self.navigationItem.rightBarButtonItems = [self.editButtonItem, self.addButton]
        tableView.allowsMultipleSelectionDuringEditing = true
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //    @objc func deleteItems(_ sender: Any) {
    //        if let selectRows = tableView.indexPathsForSelectedRows {
    //            var items = [Plan]()
    //            for indexPath in selectRows {
    //                items.append(plans[indexPath.row])
    //            }
    //            planDelegate.remove(items: items)
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: selectRows, with: .automatic)
    //            tableView.endUpdates()
    //
    //        }
    //    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        tableView.setEditing(tableView.isEditing, animated: true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return plans!.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    // about deta the cell has
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "callingItem", for:indexPath) as? callingItemTableViewCell)!
        
        //        let orderCellNum = plans![indexPath.row].order as? Int
        
        cell.nameCallingForLabel.text = plans?[indexPath.row].nameCallingFor
        
        cell.localTimeLabel.text =  plans?[indexPath.row].localDate?.convertToString(dateformat: .time, timeZoneIdentifier: (plans?[indexPath.row].localName)!)
        
        cell.localDateLabel.text =  plans?[indexPath.row].localDate?.convertToString(dateformat: .date, timeZoneIdentifier: (plans?[indexPath.row].localName)!)
        
        cell.destinationNameLabel.text = plans?[indexPath.row].destinationName
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //        planDelegate.move(item: plans[sourceIndexPath.row], index: destinationIndexPath.row)
    //    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        // tableView.cellForRow(at: indexPath) means it return the cell user tapped
        if let cell = tableView.cellForRow(at: indexPath) {
            let item =  plans?[indexPath.row]
            //           configureCheckmark(for: cell, with: item)
            // tableView.deselectRow(at: indexPath, animated: true) stop highlighting the cell after user release finger.
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
          
            plans?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       
        let item = plans![sourceIndexPath.row]
        //        context.delete(item)
        //        context.insert(item)
        
        
        plans?.remove(at: sourceIndexPath.row)
        plans?.insert(item, at: destinationIndexPath.row)
        
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showDetailSegue", tableView.isEditing {
            return false
        }
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            if let addItemViewController = segue.destination as? addingCallingItemTableViewController {
                addItemViewController.delegate = self
                addItemViewController.isEditting = false
            }
        }
        else if segue.identifier == "showDetailSegue" {
            if let detailVC = segue.destination as? DetailCallingTableViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = plans?[indexPath.row]
                    detailVC.item = item!
                    detailVC.indexPath = indexPath
                    detailVC.delegate = self
                    detailVC.isFirstDateValuePassed = true
                    detailVC.isEditting = true
                }
            }
        }
    }
}

extension callinglistViewController: AddItemTableViewControllerDelegate {
    func addItemViewController(_ controller: addingCallingItemTableViewController, didFinishAdding item: Plan) {
       
//
//        plans?.append(item)
        
        //        self.callingCelllist.callingList.append(item)
        dataManager.addPlan(plan: item)
        dataManager.getData()
        
        guard let rowIndex = plans?.count else { return }
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func addItemTableViewControllerDidCancel(_ controller: addingCallingItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
//    func addItemViewController(_ controller: addingCallingItemTableViewController, didFinishAdding item: Plan) {
//        guard let rowIndex = plans?.count else { return }
//        appDelegate.saveContext()
//        plans?.append(item)
//        let indexPath = IndexPath(row: rowIndex, section: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRows(at: indexPaths, with: .automatic)
//    }
//

    
}

extension callinglistViewController: DetailCallingTableViewControllerDelegate {
    func DetailCallingTableViewController(_ controller: DetailCallingTableViewController, didFinishEditting item: Plan, indexPath: IndexPath) {
        
        print(item.localDate!)

       
        
        self.tableView.reloadData()
    }
    
    func DetailCallingTableViewController(_ controller: DetailCallingTableViewController, addNewItem item: Plan, indexPath: IndexPath){
        guard let rowIndex = plans?.count else { return }
       
        plans?.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
}

extension callinglistViewController: DataManagerDelegate {
    func gotData(plans: [Plan]) {
        self.plans = plans
        self.plans?.sort { $0.localDate!.compare($1.localDate!) == .orderedDescending  }
    }
}
