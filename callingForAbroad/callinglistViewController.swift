//
//  ViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-07.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class callinglistViewController: UITableViewController {
    
    var CallingCelllist = callingCellList()

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
       
        tableView.rowHeight = 100.0
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CallingCelllist.callingList.count
    }
    
    
    // about deta the cell has
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "callingItem", for:indexPath)
        let item = CallingCelllist.callingList[indexPath.row]
        
        if let label1000 = cell.viewWithTag(1000) as? UILabel {
            label1000.text = CallingCelllist.callingList[indexPath.row].NameCallingFor
        }
        if let label999 = cell.viewWithTag(999) as? UILabel {
            label999.text = CallingCelllist.callingList[indexPath.row].localTime
        }
        
        configureCheckmark(for: cell, with: item)
        tableView.deselectRow(at: indexPath, animated: true)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.cellForRow(at: indexPath) means it return the cell user tapped
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = CallingCelllist.callingList[indexPath.row]
           configureCheckmark(for: cell, with: item)
            // tableView.deselectRow(at: indexPath, animated: true) stop highlighting the cell after user release finger.
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        CallingCelllist.callingList.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        // can also delete cell visually, but it doesn't show animation.
        //tableView.reloadData()
    }
    
    
    
    func nameCallingFor(for cell:UITableViewCell, with item: callingCellItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.NameCallingFor
        }
    }
    
    func localTime(for cell:UITableViewCell, with item: callingCellItem) {
        if let label = cell.viewWithTag(999) as? UILabel {
            label.text = item.localTime
        }
    }
    
    
    
    func configureCheckmark(for cell:UITableViewCell, with item: callingCellItem) {
       
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        item.toggleChecked()
    }
}

