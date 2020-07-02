//
//  EditePlayerTableViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import RealmSwift

class EditePlayerTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
    
    let arrayPosition = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    let arrayTeamNumber = ["0", "1", "2", "3", "4"]
    
    var positionPickerView: PickerView?
    var teamNumberPickerView: PickerView?
    
    var positionToolBar: UIToolbar?
    var teamNumberToolBar: UIToolbar?
    
    var imageIsChange = false
    
    var player: Player!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionPickerView = PickerView()
        teamNumberPickerView = PickerView()
        
        setPickerView(picker: positionPickerView!, textField: position, arrayData: arrayPosition)
        setPickerView(picker: teamNumberPickerView!, textField: teamNumber, arrayData: arrayTeamNumber)
        
        positionToolBar = UIToolbar()
        teamNumberToolBar = UIToolbar()
        
        positionToolBar(toolBar: positionToolBar)
        teamNumberToolBar(toolBar: teamNumberToolBar)
        
        setStat()
        
        tableView.tableFooterView = UIView()
        
    }
    
    private func setStat() {
        imagePlayer.image = UIImage(data: player.photo!)
        namePlayer.text = player.name
        teamNumber.text = String(player.teamNumber)
        payment.text = player.payment
        position.text = player.position
        iGo.isOn = player.isFavourite
        rating.text = String(player.rating)
        numberOfGames.text = String(player.numberOfGames)
        numberOfGoals.text = String(player.numberOfGoals)
        winGame.text = String(player.winGame)
        losGame.text = String(player.losGame)
    }
    
    private func setPickerView(picker: PickerView,
                               textField: UITextField,
                               arrayData: [String]) {
        
        picker.data = arrayData
        setDarkAndLightModePicker(picker)
        picker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textField.inputView = picker
        setDarkAndLightModePicker(picker)
    }
    
    func setDarkAndLightModePicker(_ picker: PickerView ) {
        
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
        teamNumber.text = teamNumberPickerView?.selectedValue
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
    
    @objc func cancelBtn(_ button: UIBarButtonItem?, item: UITextField) {
        position.resignFirstResponder()
    }
    @objc func doneBtn(_ button: UIBarButtonItem?) {
        position?.resignFirstResponder()
        position.text = positionPickerView?.selectedValue
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera") // image literal
            let photoIcon = #imageLiteral(resourceName: "photo")  // image literal
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera",
                                       style: .default) { _ in
                                        self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo",
                                      style: .default) { _ in
                                        self.chooseImagePicker(source: .photoLibrary)
            }
            
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    // Метод сообщает что выбран статичный фрагмен видео или фото
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePlayer.image = info[.editedImage] as? UIImage
        imagePlayer.contentMode = .scaleAspectFill
        imagePlayer.clipsToBounds = true
        dismiss(animated: true)
    }
    
    func savePlayer() {
        try! realm.write {
            player.photo = imagePlayer.image?.pngData()
            player.name = namePlayer.text
            player.teamNumber = Int(teamNumber.text!)!
            player.payment = payment.text!
            player.isFavourite = iGo.isOn
            player.rating = Int(rating.text!)!
            player.position = position.text!
            player.numberOfGames = Int(numberOfGames.text!)!
            player.numberOfGoals = Int(numberOfGoals.text!)!
            player.winGame = Int(winGame.text!)!
            player.losGame = Int(losGame.text!)!
        }
    }
    
}

extension EditePlayerTableViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
