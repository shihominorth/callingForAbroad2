//
//  DetailCallingTableViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-22.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class DetailCallingTableViewController: UITableViewController {
    
    var CallingCelllist = callingCellList()
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItemSegue" {
        if let addItemViewController = segue.destination as? addCallingItemViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let item = CallingCelllist.callingList[indexPath.row]
                addItemViewController.itemToEdit = item
            }
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
            
            cell.NameCallingForLabel.text = item.NameCallingFor
            

            // Configure the cell...

            return cell
        }
        else if indexPath.section == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "date Calling", for: indexPath) as? DateCallingTableViewCell)!

                // Configure the cell...
            cell.DateCallingLabel.text = item.dateCalling
                return cell
            }
        else if indexPath.section == 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local Name", for: indexPath) as? LocalNameTableViewCell)!

            // Configure the cell...

            cell.localNameLabel.text = item.localTime
            
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

extension DetailCallingTableViewController {
//    func assignImformationToCell(index: Int) {
//
//
//        let nameCallingForTableViewCell = NameCallingForTableViewCell()
//        let dateCallingTableViewCell = DateCallingTableViewCell()
//        let localTimeTableViewCell = LocalTimeTableViewCell()
//        let localNameTableViewCell = LocalNameTableViewCell()
//        let destinationNameTableViewCell = DestinationNameTableViewCell()
//        let jetLagTableViewCell = JetLagTableViewCell()
//        let destinationTimeTableViewCell = DestinationTimeTableViewCell()
//
//
//
//            nameCallingForTableViewCell.NameCallingForLabel.text = item.NameCallingFor
//            dateCallingTableViewCell.DateCallingLabel.text = item.dateCalling
//
//            localNameTableViewCell.localNameLabel.text = item.localName
//
//
//            localTimeTableViewCell.LocalTimeLabel.text = item.localTime
//
//
//            destinationNameTableViewCell.DestinationNameLabel.text = item.destinationName
//
//
//            jetLagTableViewCell.jetLagLabel.text = item.jetLag
//
//
//            destinationTimeTableViewCell.destinationTimeLabel.text = item.destinationTime
//    }
}
