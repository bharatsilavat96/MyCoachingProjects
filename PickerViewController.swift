//
//  PickerViewController.swift
//  HUMAN
//
//  Created by Bharat Silavat on 30/01/23.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var pickerHeight: NSLayoutConstraint!
    @IBOutlet var selectionTxtFld: UITextField!
    var countryList : [Contries] = []
    var selectedCountry: String = ""
    var selectedCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPicker()
        self.selectionTxtFld.delegate = self
        self.pickerHeight.constant = 0.0
        self.pickerHeight.isActive = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    func getPicker(){
        guard let url = Bundle.main.url(forResource: "Contries", withExtension: "json") else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            countryList = try decoder.self.decode([Contries].self, from: data)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.pickerView.reloadAllComponents()
            }
        }catch let error {
            print("Error \(error)")
        }
    }
}

extension PickerViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
        return 2
    }
}

//MARK: UIPICkerDelegate Method -
extension PickerViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let Country = countryList[row]
        if component == 0 {
            return Country.name
        }
        else {
            return Country.code
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countryList[row]
        if component == 0 {
            selectedCountry = country.name ?? ""
        } else {
            selectedCode = country.code ?? ""
        }
        self.selectionTxtFld?.text = "\(selectedCountry) \(selectedCode)"
    }
    
}

//MARK: - UITextFieldDelegate  -

extension PickerViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        pickerHeight.isActive = true
        pickerHeight.constant = 260
        self.view.layoutIfNeeded()
        return false
    }
  
}
