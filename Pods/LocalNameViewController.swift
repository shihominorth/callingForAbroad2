//
//  LocalNameViewController.swift
//  callingForAbroad
//
//  Created by 北島　志帆美 on 2020-02-08.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit


protocol LocalNameViewControllerDelegate: class {
//     func editItemViewController(_ controller: LocalNameViewController, didFinishEditting item: callingCellItem)
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting item: Plan)

}

protocol LocalNameViewControllerDelegate2: class {
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting localName: String!)
}

class LocalNameViewController: UIViewController {

    
    var item: Plan?
    var indexPath = IndexPath()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var text = ""
    
    weak var delegate:LocalNameViewControllerDelegate?
    
    var isAdding: Bool?
    weak var delegate2:LocalNameViewControllerDelegate2?
    
    @IBAction func done(_ sender: Any) {
        
        if isAdding != true {
            item?.localName = textField.text
            delegate?.editItemViewController(self, didFinishEditting: item!)
        } else {
            if textField.text == "" {
               textField.text = "NONE"
            }
            delegate2?.editItemViewController(self, didFinishEditting: textField.text)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if item?.localName != nil {
            textField.text = item!.localName
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
