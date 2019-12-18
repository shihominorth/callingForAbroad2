//
//  EdittingDetailTableViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-18.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class EdittingDetailTableViewController: UITableViewController {

    var item = callingCellItem()
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting NameCalling", for: indexPath) as? EdittingNameCallingForTableViewCell)!
               
               cell.textFiled.text = item.NameCallingFor
               

               // Configure the cell...

               return cell
           }
           else if indexPath.section == 1 {
                   let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting date Calling", for: indexPath) as? EdittingDateCallingTableViewCell)!

                   // Configure the cell...
               cell.textFiled.text = item.dateCalling
                return cell
            
            }
           else if indexPath.section == 2 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting local Name", for: indexPath) as? EdittingLocalNameTableViewCell)!

               // Configure the cell...

               cell.textField.text = item.localName
               
               return cell
           }
           
           else if indexPath.section == 3 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting local Time", for: indexPath) as? EdittingLocalTimeTableViewCell)!

               // Configure the cell...
               cell.textField.text = item.localTime

               return cell
           }
           else if indexPath.section == 4 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting destination Name", for: indexPath) as? EdittingDestinationNameTableViewCell)!

               // Configure the cell...

               cell.textField.text = item.destinationName
               return cell
           }
           else if indexPath.section == 5 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting jet Lag", for: indexPath) as? EdittingJetLagTableViewCell)!
    
               // Configure the cell...
               cell.textField.text = item.jetLag

               return cell
           }
           else if indexPath.section == 6 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting destination Time", for: indexPath) as? EdittingDestinationTimeTableViewCell)!

               // Configure the cell...
               cell.textField.text = item.destinationTime

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
