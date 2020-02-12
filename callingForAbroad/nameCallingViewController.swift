//
//  nameCallingViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-08.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

protocol nameCallingViewControllerDelegate: class {
    
//    func editItemViewController(_ controller: nameCallingViewController, didFinishEditting item: callingCellItem)
    func editItemViewController(_ controller: nameCallingViewController, didFinishEditting item: Plan)

}

class nameCallingViewController: UIViewController {

    
    var item = Plan()
    var indexPath = IndexPath()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate:nameCallingViewControllerDelegate?
    
    @IBAction func done(_ sender: Any) {
        
        item.nameCallingFor = textField.text ?? ""
        delegate?.editItemViewController(self, didFinishEditting: item)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.text = item.nameCallingFor
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
