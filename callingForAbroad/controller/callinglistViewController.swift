//
//  ViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-07.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class callinglistViewController: UITableViewController {
    
    let CallingCelllist = callingCellList()

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
        navigationController?.navigationBar.prefersLargeTitles = false
//        
//        let app = UINavigationBarAppearance()
//        app.backgroundColor = UIColor(red: 0.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
//        self.navigationController?.navigationBar.scrollEdgeAppearance = app

        //UINavigationBar..UINavigationBarAppearance.color
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
        if let label555 = cell.viewWithTag(555) as? UILabel {
            label555.text = CallingCelllist.callingList[indexPath.row].localName
        }
        if let label333 = cell.viewWithTag(333) as? UILabel {
            label333.text = CallingCelllist.callingList[indexPath.row].dateCalling
        }
        if let label111 = cell.viewWithTag(111) as? UILabel {
            label111.text = CallingCelllist.callingList[indexPath.row].destinationName
        }
        if let label222 = cell.viewWithTag(222) as? UILabel {
            label222.text = CallingCelllist.callingList[indexPath.row].jetLag
        }
        if let label666 = cell.viewWithTag(666) as? UILabel {
            label666.text = CallingCelllist.callingList[indexPath.row].destinationTime
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
    
    
    
    func cellText(for cell:UITableViewCell, with item: callingCellItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.NameCallingFor
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
            label.text = item.dateCalling
        }
        else if let label = cell.viewWithTag(111) as? UILabel {
            label.text = item.dateCalling
        }
        else if let label = cell.viewWithTag(222) as? UILabel {
            label.text = item.jetLag
        }
        else if let label = cell.viewWithTag(666) as? UILabel {
            label.text = item.destinationTime
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? addCallingItemViewController {
                addItemViewController.delegate = self
                addItemViewController.itemList = CallingCelllist
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addItemViewController = segue.destination as? addCallingItemViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = CallingCelllist.callingList[indexPath.row]
                    addItemViewController.itemToEdit = item
                    
                }
            }
        }
        else if segue.identifier == "showDetailSegue" {
            if let detailVC = segue.destination as? DetailCallingTableViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = CallingCelllist.callingList[indexPath.row]
                    detailVC.item = item
                    detailVC.indexPath = indexPath
                }
            }
        }
    }
}


extension callinglistViewController: AddViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: addCallingItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: addCallingItemViewController, didFinishAdding item: callingCellItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = CallingCelllist.callingList.count
        CallingCelllist.callingList.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
}

