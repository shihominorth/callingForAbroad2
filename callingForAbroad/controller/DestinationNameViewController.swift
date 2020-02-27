//
//  DestinationNameViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-08.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

protocol DestinationNameViewControllerDelegate: class {
     func editItemViewController(_ controller: DestinationNameViewController, didFinishEditting item: Plan)
}

protocol DestinationNameViewControllerDelegate2: class {
    func editItemViewController(_ controller: DestinationNameViewController, destinationName: String)
}


class DestinationNameViewController: UIViewController {

    
    var item: Plan?
    var indexPath = IndexPath()
    var text: String?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate:DestinationNameViewControllerDelegate?
    
    weak var delegate2:DestinationNameViewControllerDelegate2?
    
    var isAdding: Bool?
    
    @IBAction func done(_ sender: Any) {
        
       
        
        if isAdding != true {
            item?.destinationName = textField.text ?? ""
            delegate?.editItemViewController(self, didFinishEditting: item!)
        } else {
            if textField.text == "" {
               textField.text = "NONE"
            }
            delegate2?.editItemViewController(self, destinationName: textField.text!)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if item?.localName != nil {
            textField.text = item?.localName
        }
        else if text != "" {
            textField.text = text
        }
        else {
         textField.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

