//
//  nameCallingViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-08.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

protocol nameCallingViewControllerDelegate: class {
    
    func editItemViewController(_ controller: nameCallingViewController, didFinishEditting item: Plan)

}

protocol nameCallingViewControllerDelegate2: class {
    func editItemViewController(_ controller: nameCallingViewController, nameCallFor: String)
}

class nameCallingViewController: UIViewController {

    var item: Plan?
    
    var text = ""
    var indexPath = IndexPath()
    
    var isAdding: Bool?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate:nameCallingViewControllerDelegate?
    weak var delegate2: nameCallingViewControllerDelegate2?
    
    @IBAction func done(_ sender: Any) {
        
       
        
        if isAdding != true {
            item?.nameCallingFor = textField.text ?? ""
            delegate?.editItemViewController(self, didFinishEditting: item!)
        } else {
            if textField.text == nil {
               textField.text = "NONE"
            }
            delegate2?.editItemViewController(self, nameCallFor: textField.text!)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if item?.nameCallingFor != nil {
            textField.text = item?.nameCallingFor
        }
        else if text != "" {
         textField.text = text
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
