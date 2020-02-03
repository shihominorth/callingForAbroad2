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
    var section1: Dictionary = [String:NSMutableArray]()
    var section2: Dictionary = [String:NSMutableArray]()
    var sections: Array = [Dictionary<String,NSMutableArray>]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var plans = [Plan]()

    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    // i want to change this icon to gear icon
    
//    @IBAction func userSettings(_ sender: Any) {
//        let newRowIndex = CallingCelllist.callingList.count
//        _ = CallingCelllist.newToDo()
//        let indexPath = IndexPath(row: newRowIndex, section: 0)
//        let indexPaths = [indexPath]
//        
//        tableView.insertRows(at: indexPaths, with: .automatic)
//    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        navigationController?.navigationBar.prefersLargeTitles = false
        let delete = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteItems))
        //let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: <#T##Selector?#>)
        navigationItem.rightBarButtonItems = [editButtonItem, delete, addButton]
        tableView.allowsMultipleSelectionDuringEditing = true
//        let app = UINavigationBarAppearance()
//        app.backgroundColor = UIColor(red: 0.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
//        self.navigationController?.navigationBar.scrollEdgeAppearance = app

        //UINavigationBar..UINavigationBarAppearance.color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            plans = try context.fetch(Plan.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    @objc func deleteItems(_ sender: Any) {
        if let selectRows = tableView.indexPathsForSelectedRows {
            var items = [callingCellItem]()
            for indexPath in selectRows {
                items.append(callingCelllist.callingList[indexPath.row])
            }
            callingCelllist.remove(items: items)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectRows, with: .automatic)
            tableView.endUpdates()
            
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(tableView.isEditing, animated: true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return callingCelllist.callingList.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    // about deta the cell has
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "callingItem", for:indexPath) as? callingItemTableViewCell)!
        
        cell.nameCallingForLabel.text = callingCelllist.callingList[indexPath.row].nameCallingFor
       
        cell.localTimeLabel.text = callingCelllist.callingList[indexPath.row].localTime
    
        //cell.localNameLabel.text = callingCelllist.callingList[indexPath.row].localName
   
        cell.localDateLabel.text = callingCelllist.callingList[indexPath.row].localDate
   
       cell.destinationNameLabel.text = callingCelllist.callingList[indexPath.row].destinationName
   
        //cell.jetLagLabel.text = callingCelllist.callingList[indexPath.row].jetLag
    
       // cell.destinationTimeLabel.text = callingCelllist.callingList[indexPath.row].destinationTime

        tableView.deselectRow(at: indexPath, animated: true)
            
       return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        callingCelllist.move(item: callingCelllist.callingList[sourceIndexPath.row], to: destinationIndexPath.row)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        // tableView.cellForRow(at: indexPath) means it return the cell user tapped
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = callingCelllist.callingList[indexPath.row]
//           configureCheckmark(for: cell, with: item)
            // tableView.deselectRow(at: indexPath, animated: true) stop highlighting the cell after user release finger.
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        callingCelllist.callingList.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        // can also delete cell visually, but it doesn't show animation.
        //tableView.reloadData()
    }
    
    
    
    func cellText(for cell:UITableViewCell, with item: callingCellItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.nameCallingFor
        }
        else if let label = cell.viewWithTag(999) as? UILabel {
            label.text = item.localTime
        }
        else if let label = cell.viewWithTag(999) as? UILabel {
            label.text = item.localTime
        }
        else if let label = cell.viewWithTag(555) as? UILabel {
            label.text = item.localName
        }
        else if let label = cell.viewWithTag(333) as? UILabel {
            label.text = item.localDate
        }
        else if let label = cell.viewWithTag(111) as? UILabel {
            label.text = item.localDate
        }
        else if let label = cell.viewWithTag(222) as? UILabel {
            label.text = item.jetLag
        }
        else if let label = cell.viewWithTag(666) as? UILabel {
            label.text = item.destinationTime
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showDetailSegue", tableView.isEditing {
            return false
        }
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? addingCallingItemTableViewController {
                addItemViewController.delegate = self
                //addItemViewController.callingCellList = callingCelllist
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addItemViewController = segue.destination as? addCallingItemViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = callingCelllist.callingList[indexPath.row]
                    addItemViewController.itemToEdit = item
                    
                }
            }
        }
        else if segue.identifier == "showDetailSegue" {
            if let detailVC = segue.destination as? DetailCallingTableViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = callingCelllist.callingList[indexPath.row]
                    detailVC.item = item
                    detailVC.indexPath = indexPath
                    detailVC.delegate = self
                }
            }
        }
    }
}


//extension callinglistViewController: AddViewControllerDelegate {
//    func addItemViewControllerDidCancel(_ controller: addCallingItemViewController) {
//        navigationController?.popViewController(animated: true)
//    }
//
//    func addItemViewController(_ controller: addCallingItemViewController, didFinishAdding item: callingCellItem) {
//        navigationController?.popViewController(animated: true)
//        let rowIndex = CallingCelllist.callingList.count
//        CallingCelllist.callingList.append(item)
//        let indexPath = IndexPath(row: rowIndex, section: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRows(at: indexPaths, with: .automatic)
//    }
//
//
//}

extension callinglistViewController: AddItemTableViewControllerDelegate {
    func addItemTableViewControllerDidCancel(_ controller: addingCallingItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: addingCallingItemTableViewController, didFinishAdding item: callingCellItem) {
        let rowIndex = callingCelllist.callingList.count
              callingCelllist.callingList.append(item)
              let indexPath = IndexPath(row: rowIndex, section: 0)
              let indexPaths = [indexPath]
              tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
}

extension callinglistViewController: DetailCallingTableViewControllerDelegate {
    func DetailCallingTableViewController(_ controller: DetailCallingTableViewController, didFinishEditting item: callingCellItem, indexPath: IndexPath) {
        
        
        callingCelllist.callingList.remove(at: indexPath.row)
        callingCelllist.callingList.insert(item, at: indexPath.row)
        
        self.tableView.reloadData()
           
    }
    
    
}
