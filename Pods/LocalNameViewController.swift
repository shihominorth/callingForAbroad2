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
    
    var cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
    var city = ""
    
    
    var picker:UIPickerView?
    
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
        
//        textField.inputView = picker

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
        
        //picker.isHidden = true

        //picker.reloadAllComponents()
        
        print(cityNamesTimezone)
        
        textField.addTarget(self, action: #selector(showUpPicker), for: .touchDown)
        
        
        
    }
    
    
    @objc func showUpPicker() {
        self.picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.picker?.delegate = self
        self.picker?.dataSource = self
        textField.inputView = self.picker

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()

        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(LocalNameViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(LocalNameViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    //MARK:- Button
    @objc func doneClick() {
        textField.resignFirstResponder()
    }
    @objc func cancelClick() {
        textField.resignFirstResponder()
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


extension LocalNameViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          print(row)
          return cityNamesTimezone[row]
      }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
}
extension LocalNameViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
  
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityNamesTimezone.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = cityNamesTimezone[row]
//        self.view.endEditing(true)
    }
    
    
}

extension LocalNameViewController: UITextFieldDelegate {
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        self.view.endEditing(false)
//
//        return true
//    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.showUpPicker(textField: self.textField)
//    }
}
