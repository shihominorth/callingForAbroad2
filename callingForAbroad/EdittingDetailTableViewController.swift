//
//  EdittingDetailTableViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-18.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

protocol EditItemTableViewControllerDelegate: class {
    func editItemViewController(_ controller: EdittingDetailTableViewController, didFinishEditting item: callingCellItem)
}

class EdittingDetailTableViewController: UITableViewController {

    weak var editItem:callingCellItem?
//    var indexPath = IndexPath()
    weak var delegate: EditItemTableViewControllerDelegate?
    weak var callingCellList:CallingCellList?
    
    @IBOutlet weak var textField: UITextField!
//    @IBAction func done(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//
//        if let item = editItem, let text =  textField.text {
//            item.nameCallingFor = text
//            delegate?.editItemViewController(self, didFinishEditting: item)
//        }
//    }
    
    
    // something happen inside here
    // when clicking the item bar button app carsh.
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    private func registerCell() {
        
        self.tableView.register(EdittingNameCallingForTableViewCell.self, forCellReuseIdentifier: "Editting NameCalling")
        
        self.tableView.register(EdittingDateCallingTableViewCell.self,
                                forCellReuseIdentifier: "Editting date Calling")
        
        self.tableView.register(EdittingLocalNameTableViewCell.self,
                                forCellReuseIdentifier: "Editting local Name")

        self.tableView.register(EdittingLocalTimeTableViewCell.self,
                                forCellReuseIdentifier: "Editting local Time")

        self.tableView.register(EdittingDestinationNameTableViewCell.self,
                                forCellReuseIdentifier: "Editting destination Name")

        self.tableView.register(EdittingJetLagTableViewCell.self,
                                forCellReuseIdentifier: "Editting jet Lag")

        self.tableView.register(EdittingDestinationTimeTableViewCell.self,
                                forCellReuseIdentifier: "Editting destination Time")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           if indexPath.row == 0 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting NameCalling", for: indexPath) as? EdittingNameCallingForTableViewCell)!
               
               cell.textFiled.text = editItem?.nameCallingFor
               

               // Configure the cell...

               return cell
           }
           else if indexPath.row == 1 {
                   let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting date Calling", for: indexPath) as? EdittingDateCallingTableViewCell)!

                   // Configure the cell...
            cell.textFiled.text = editItem?.localDate
                return cell
            
            }
           else if indexPath.row == 2 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting local Name", for: indexPath) as? EdittingLocalNameTableViewCell)!

               // Configure the cell...

               cell.textField.text = editItem?.localName
               
               return cell
           }
           
           else if indexPath.row == 3 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting local Time", for: indexPath) as? EdittingLocalTimeTableViewCell)!

               // Configure the cell...
               cell.textField.text = editItem?.localTime

               return cell
           }
           else if indexPath.row == 4 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting destination Name", for: indexPath) as? EdittingDestinationNameTableViewCell)!

               // Configure the cell...

               cell.textField.text = editItem?.destinationName
               return cell
           }
           else if indexPath.row == 5 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting jet Lag", for: indexPath) as? EdittingJetLagTableViewCell)!
    
               // Configure the cell...
               cell.textField.text = editItem?.jetLag

               return cell
           }
           else if indexPath.row == 6 {
               let cell = (tableView.dequeueReusableCell(withIdentifier: "Editting destination Time", for: indexPath) as? EdittingDestinationTimeTableViewCell)!

               // Configure the cell...
               cell.textField.text = editItem?.destinationTime

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
