//
//  PickerView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class PickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public var textFieldBeingEdited: UITextField?
    
    public var data: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }
    
    public var selectedValue: String {
        get {
            if data != nil {
                return data![selectedRow(inComponent: 0)]
            } else {
                return ""
            }
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if data != nil {
            return data!.count
        } else {
            return 0
        }
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if data != nil {
            return data![row]
        } else {
            return ""
        }
    }
}
