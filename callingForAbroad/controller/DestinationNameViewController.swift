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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeLabel: UILabel!
    
    
    weak var delegate:DestinationNameViewControllerDelegate?
    
    weak var delegate2:DestinationNameViewControllerDelegate2?
    
    var isAdding: Bool?
    
    var cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
    var city = ""
    //    var picker:UIPickerView?
    
    
    
    @IBAction func done(_ sender: Any) {
        
        
        if isAdding != true {
            item?.destinationName = placeLabel.text ?? ""
            delegate?.editItemViewController(self, didFinishEditting: item!)
        } else {
            if placeLabel.text == "Type the place" {
                placeLabel.text = "NONE"
            }
            delegate2?.editItemViewController(self, destinationName: placeLabel.text!)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    func nameRegion() -> [String] {
        
        var names:[String] = []
        
        for identifier in cityNamesTimezone {
            let regionName = identifier.split(separator: "/")
            
            if !names.contains(String(regionName[0])) {
                names.append(String(regionName[0]))
                
                
            }
            
        }
        
        return names
        //        var names:[String] = []
        //        cityNamesTimezone.map { $0 -> [String] in
        //            var array:[String] = []
        //            let region = $0.split(separator: "/")
        //
        //            if !array.contains(String(region[0])) {
        //                array.append(String(region[0]))
        //            }
        //
        //            return array
        //        }
        
        
        
    }
    
    func nameCities(regionName: String) -> [String] {
        
        var arr:[String] = []
        
        for timezone in cityNamesTimezone {
            let regionFromCityNamesTimeZone = timezone.split(separator: "/")
            
            if regionName == regionFromCityNamesTimeZone[0] {
                arr.append(String(timezone))
            }
        }
    
        
        return arr
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if item?.destinationName != nil {
            searchBar.text = item?.destinationName
            placeLabel.text = item?.destinationName
        }
        else if text != "" {
            searchBar.text = text
            placeLabel.text = text
        }
        else {
            searchBar.text = ""
            placeLabel.text = "Type the place"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
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


extension DestinationNameViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let regions = nameRegion()
        
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let regions = nameRegion()
        var arr:[String] = []
        
        for (index, region) in regions.enumerated() {
            if section == index {
                arr = nameCities(regionName: region)
                return arr.count
            }
        }
        
        //        for region in regions {
        //            arr = nameCities(regionName: region)
        //            return arr.count
        //        }
        //
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let regions = nameRegion()
        var cities:[String] = []
        
        let cell  = (tableView.dequeueReusableCell(withIdentifier: "destinationCity") as? DestinationCityNameTableViewCell)!
        
        for (index, region) in regions.enumerated() {
            if indexPath.section == index {
                
                cities = nameCities(regionName: region)
                cell.label.text = cities[indexPath.row]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let regions = nameRegion()
        
        return regions[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let regions = nameRegion()
        
               for (index, region) in regions.enumerated() {
                   if indexPath.section == index {

                       let cities = nameCities(regionName: region)
                       item?.destinationName = cities[indexPath.row]
                    placeLabel.text = cities[indexPath.row]
                     
                   }
               }
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension DestinationNameViewController: UITableViewDelegate {
    
}


extension DestinationNameViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var temp: [String] = []
        
        if searchBar.text != "" {
            
            let text = searchBar.text!
            
            for city in cityNamesTimezone {
                
                if city.contains(text){
                    temp.append(city)
                }
            }
            print(temp)
            
            cityNamesTimezone.removeAll()
            cityNamesTimezone = temp
            
            tableView.reloadData()
            
        } else {
            cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
            tableView.reloadData()
        }
        
    }
    
    
    
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
//        navigationController?.popViewController(animated: true)
    }
    
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
