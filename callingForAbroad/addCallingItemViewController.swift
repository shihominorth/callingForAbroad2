//
//  addCallingItemViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-14.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class addCallingItemViewController: UIViewController {
   
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    
    
    // when you connect bar item button with IBAction, the name of function should be same as the name of bar button item.
    @IBAction func Add(_ sender: Any) {
        navigationController?.popViewController(animated: true)
//        print("content of text field is \(callingNametextFild.text)")
    }
    
    
    
    @IBAction func Cancel(_ sender: Any) {
        
        // it doesn't show any error if the code was comment out.
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var callingNametextFild: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // without tapping, the keyboard will show automatically.
        callingNametextFild.becomeFirstResponder()
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

extension addCallingItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callingNametextFild.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addBarButton.isEnabled = false
        } else {
            addBarButton.isEnabled = true
        }
        
        return true
    }
}
