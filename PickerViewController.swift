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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPicker()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    func getPicker(){
        guard let url = Bundle.main.url(forResource: "Contries", withExtension: "json") else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            countryList = try decoder.self.decode([Contries].self, from: data)
            DispatchQueue.main.async {
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
        return 1
    }
}
extension PickerViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let Country = countryList[row]
        return Country.name
    }
}
