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
    
    var cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
    var city = ""
//    var picker:UIPickerView?

    
    
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
        if item?.destinationName != nil {
            textField.text = item?.destinationName
        }
        else if text != "" {
            textField.text = text
        }
        else {
         textField.text = ""
        }
        
       // textField.addTarget(self, action: #selector(showUpPicker), for: .touchDown)
    }
    
    
       
//       @objc func showUpPicker() {
//           self.picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
//           self.picker?.delegate = self
//           self.picker?.dataSource = self
//           textField.inputView = self.picker
//
//           // ToolBar
//           let toolBar = UIToolbar()
//           toolBar.barStyle = .default
//           toolBar.isTranslucent = true
//           toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//           toolBar.sizeToFit()
//
//           // Adding Button ToolBar
//           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(LocalNameViewController.doneClick))
//           let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(LocalNameViewController.cancelClick))
//           toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//           toolBar.isUserInteractionEnabled = true
//           textField.inputAccessoryView = toolBar
//       }
//
//       //MARK:- Button
//       @objc func doneClick() {
//           textField.resignFirstResponder()
//       }
//       @objc func cancelClick() {
//           textField.resignFirstResponder()
//       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension DestinationNameViewController: UIPickerViewDelegate {
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//          print(row)
//          return cityNamesTimezone[row]
//      }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 40.0
//    }
//}
//extension DestinationNameViewController: UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return cityNamesTimezone.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        textField.text = cityNamesTimezone[row]
//    }
//
//
//}
