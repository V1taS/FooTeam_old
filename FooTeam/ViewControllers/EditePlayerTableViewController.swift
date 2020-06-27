//
//  EditePlayerTableViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class EditePlayerTableViewController: UITableViewController {
    
    @IBOutlet weak var imagePlayer: UIImageView!
    @IBOutlet weak var namePlayer: UITextField!
    @IBOutlet weak var teamNumber: UITextField!
    @IBOutlet weak var payment: UITextField!
    @IBOutlet weak var iGo: UISwitch!
    @IBOutlet weak var rating: UITextField!
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var numberOfGames: UITextField!
    @IBOutlet weak var numberOfGoals: UITextField!
    @IBOutlet weak var winGame: UITextField!
    @IBOutlet weak var losGame: UITextField!
    
    var positionPicker: PickerView?
    var teamNumberPicker: PickerView?
    
    var positionToolBar: UIToolbar?
    var teamNumberToolBar: UIToolbar?
    
    var players: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionPicker = PickerView()
        teamNumberPicker = PickerView()
        
        positionToolBar = UIToolbar()
        teamNumberToolBar = UIToolbar()
        
        setPickerViewString(picker: positionPicker!)
        teamNumbersetPickerView(picker: teamNumberPicker!)
        
        positionToolBar(toolBar: positionToolBar)
        teamNumberToolBar(toolBar: teamNumberToolBar)
        
        setStat()
        
        tableView.tableFooterView = UIView()
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }
    
    private func setStat() {
        imagePlayer.image = UIImage(data: players.photo)
        namePlayer.text = players.name
        teamNumber.text = String(players.teamNumber)
        teamNumber.inputView = teamNumberPicker
        payment.text = players.payment
        iGo.isOn = players.isFavourite
        rating.text = String(players.rating)
        position.inputView = positionPicker
        numberOfGames.text = String(players.numberOfGames)
        numberOfGoals.text = String(players.numberOfGoals)
        winGame.text = String(players.winGame)
        losGame.text = String(players.losGame)
        
    }
    
    private func setPickerViewString(picker: PickerView) {
        
        picker.data = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
        
        // dark mode detected
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            picker.tintColor = .black
            picker.backgroundColor = .white
        case .dark:
            picker.tintColor = .white
            picker.backgroundColor = .black
        @unknown default:
            fatalError()
        }
        
        picker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    private func teamNumbersetPickerView(picker: PickerView) {
        
        picker.data = ["0", "1", "2"]
        
        // dark mode detected
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            picker.tintColor = .black
            picker.backgroundColor = .white
        case .dark:
            picker.tintColor = .white
            picker.backgroundColor = .black
        @unknown default:
            fatalError()
        }
        
        picker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func teamNumberToolBar(toolBar: UIToolbar?) {
        
        toolBar?.autoresizingMask = .flexibleHeight
        
        // dark mode detected
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            //this customization is optional
            toolBar?.barStyle = .default
            toolBar?.tintColor = .black
            toolBar?.backgroundColor = .white
            toolBar?.barTintColor = .systemGray5
            toolBar?.isTranslucent = true
        case .dark:
            //this customization is optional
            toolBar?.barStyle = .default
            toolBar?.tintColor = .white
            toolBar?.backgroundColor = .black
            toolBar?.barTintColor = .black
            toolBar?.isTranslucent = true
        @unknown default:
            fatalError()
        }
        
        var frame = toolBar?.frame
        frame?.size.height = 44.0
        toolBar?.frame = frame!
        
        let cancelButton = UIBarButtonItem(title: "Отмена",
                                           style: .done,
                                           target: self,
                                           action: #selector(cancelBtnClicked))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //a flexible space between the two buttons
        
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneBtnClicked))
        
        //Add the items to the toolbar
        toolBar?.items = [cancelButton, flexSpace, doneButton]
        
        teamNumber.inputAccessoryView = toolBar
    }
    
    /**
     Called when the cancel button of the `pickerAccessory` was clicked. Dismsses the picker
     */
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?, item: UITextField) {
        teamNumber.resignFirstResponder()
    }
    
    /**
     Called when the done button of the `pickerAccessory` was clicked. Dismisses the picker and puts the selected value into the textField
     */
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        teamNumber?.resignFirstResponder()
        teamNumber.text = teamNumberPicker?.selectedValue
    }
    
    func positionToolBar(toolBar: UIToolbar?) {
        
        toolBar?.autoresizingMask = .flexibleHeight
        
        // dark mode detected
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            //this customization is optional
            toolBar?.barStyle = .default
            toolBar?.tintColor = .black
            toolBar?.backgroundColor = .white
            toolBar?.barTintColor = .systemGray5
            toolBar?.isTranslucent = true
        case .dark:
            //this customization is optional
            toolBar?.barStyle = .default
            toolBar?.tintColor = .white
            toolBar?.backgroundColor = .black
            toolBar?.barTintColor = .black
            toolBar?.isTranslucent = true
        @unknown default:
            fatalError()
        }
        
        var frame = toolBar?.frame
        frame?.size.height = 44.0
        toolBar?.frame = frame!
        
        let cancelButton = UIBarButtonItem(title: "Отмена",
                                           style: .done,
                                           target: self,
                                           action: #selector(cancelBtn))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //a flexible space between the two buttons
        
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneBtn))
        
        //Add the items to the toolbar
        toolBar?.items = [cancelButton, flexSpace, doneButton]
        
        position.inputAccessoryView = toolBar
    }
    
    /**
     Called when the cancel button of the `pickerAccessory` was clicked. Dismsses the picker
     */
    @objc func cancelBtn(_ button: UIBarButtonItem?, item: UITextField) {
        position.resignFirstResponder()
    }
    
    /**
     Called when the done button of the `pickerAccessory` was clicked. Dismisses the picker and puts the selected value into the textField
     */
    @objc func doneBtn(_ button: UIBarButtonItem?) {
        position?.resignFirstResponder()
        position.text = positionPicker?.selectedValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
}

extension EditePlayerTableViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
