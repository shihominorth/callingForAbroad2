//
//  DetailCallingTableViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-22.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class DetailCallingTableViewController: UITableViewController {
    
    var callingCelllist = CallingCellList()
    var item = callingCellItem()
    var indexPath = IndexPath()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        assignImformationToCell(index: indexPath.row)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editting Segue" {
        if let edittingVC = segue.destination as? EdittingDetailTableViewController {
            edittingVC.editItem = self.item
            edittingVC.indexPath = self.indexPath
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "NameCalling", for: indexPath) as? NameCallingForTableViewCell)!
            
            cell.NameCallingForLabel.text = item.nameCallingFor
            

            // Configure the cell...

            return cell
        }
        else if indexPath.section == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "date Calling", for: indexPath) as? DateCallingTableViewCell)!

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
            cell.destinationTimeLabel.text = item.destinationTime

            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
    
    
    //MARK: -BUTTON
    
    @IBAction func back() {
        let row = indexPath.row
        
        if let cell: EdittingTableViewCell
            = (tableView.cellForRow(at: indexPath) as! EdittingTableViewCell) {
            
            switch row {
            case 0:
                item.nameCallingFor = cell.textField.text ?? ""
            case 1:
                item.localDate = cell.textField.text ?? ""
            case 2:
                item.localName = cell.textField.text ?? ""
            case 3:
                item.localTime = cell.textField.text ?? ""
            case 4:
                item.destinationName = cell.textField.text ?? ""
            case 5:
                item.jetLag = cell.textField.text ?? ""
            case 6:
                item.destinationTime = cell.textField.text ?? ""
            default:
                break
            }
            
            callingCelllist.callingList.remove(at: indexPath.row)
            callingCelllist.callingList.insert(item, at: indexPath.row)
        }
        
        let homeVC = storyboard?.instantiateViewController(identifier: "home") as! callinglistViewController
        
        
        navigationController?.pushViewController(homeVC, animated: true)
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

}

extension DetailCallingTableViewController: EditItemTableViewControllerDelegate {
    func editItemViewController(_ controller: EdittingDetailTableViewController, didFinishEditting item: callingCellItem) {
        
        let rowIndex = callingCelllist.callingList.index(of: item)!
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
//        if let cell:NameCallingForTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NameCallingForTableViewCell)!{
//             cell.NameCallingForLabel.text = item.nameCallingFor
//        }
//        if let cell:DateCallingTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? DateCallingTableViewCell)! {
//
//             cell.DateCallingLabel.text = item.localDate
//        }
//        if let cell:LocalNameTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? LocalNameTableViewCell)! {
//              cell.localNameLabel.text = item.localName
//        }
//        if let cell:LocalTimeTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? LocalTimeTableViewCell)! {
//             cell.LocalTimeLabel.text = item.localTime
//         }
//        if let cell:DestinationNameTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? DestinationNameTableViewCell)! {
//            cell.DestinationNameLabel.text = item.destinationName
//        }
//        if let cell:JetLagTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 5)) as? JetLagTableViewCell)! {
//             cell.jetLagLabel.text = item.jetLag
//        }
//        if let cell:DestinationTimeTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 6)) as? DestinationTimeTableViewCell)! {
//            cell.destinationTimeLabel.text = item.destinationTime
//
//        }
    }
    
    
}



