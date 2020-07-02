//
//  AddPlayerTableViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import RealmSwift

class AddPlayerTableViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var imagePlayer: UIImageView!
    @IBOutlet weak var namePlayer: UITextField!
    @IBOutlet weak var payMent: UITextField!
    @IBOutlet weak var position: UITextField!
    
    let arraypayMent = ["0", "500", "1000", "1500"]
    let arrayPosition = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    
    var payMentPickerView: PickerView?
    var positionPickerView: PickerView?
    
    var payMentToolBar: UIToolbar?
    var positionToolBar: UIToolbar?
    
    var imageIsChange = false
    var players: Results<Player>!
    var editModeIsOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payMentPickerView = PickerView()
        setPickerView(picker: payMentPickerView!, textField: payMent, arrayData: arraypayMent)
        payMentToolBar = UIToolbar()
        payMentToolBar(toolBar: payMentToolBar)
        
        positionPickerView = PickerView()
        setPickerView(picker: positionPickerView!, textField: position, arrayData: arrayPosition)
        positionToolBar = UIToolbar()
        positionToolBar(toolBar: positionToolBar)
        
        // В Футоре TableViewController избавляемся от разлиновки (от черточек) путям подставления обычного View где нет контента
        tableView.tableFooterView = UIView()
        
        // Отключаем кнопку SAVE при загрузке
        saveButton.isEnabled = false
        
        // Если поле (namePlayer) пустое то кнопка SAVE скрыта
        // Каждый раз при редактировании поля (namePlayer) будет срабатывать этот метод который в свою очередь будет вызывать метод #selector(textFieldChanged) а метод #selector(textFieldChanged) - будет следить за тем что заполнено ли текстовое поле или нет, если заполнено то кнопка SAVE будет доступна.
        namePlayer.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    //Mark: -
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
    
    //MARK: - positionToolBar
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
    
    //MARK: - payMentToolBar
    func payMentToolBar(toolBar: UIToolbar?) {
        
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
        
        payMent.inputAccessoryView = toolBar
    }
    
    /**
     Called when the cancel button of the `pickerAccessory` was clicked. Dismsses the picker
     */
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?, item: UITextField) {
        payMent.resignFirstResponder()
    }
    
    /**
     Called when the done button of the `pickerAccessory` was clicked. Dismisses the picker and puts the selected value into the textField
     */
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        payMent?.resignFirstResponder()
        payMent.text = payMentPickerView?.selectedValue
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Если наша ячейка имеет индекс 0 то пользователь должен загрузить изображение
        if indexPath.row == 0 {
            
            // Создаем два объекта с изображениями
            let cameraIcon = #imageLiteral(resourceName: "camera") // image literal
            let photoIcon = #imageLiteral(resourceName: "photo")  // image literal
            
            // Создаем экземпляр класса UIAlertController
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            // Создаем список пользовательских действий camera
            // Добавляем ключ приватности для камеры
            // NSCameraUsageDescription ($(PRODUCT_NAME) photo use)
            let camera = UIAlertAction(title: "Camera",
                                       style: .default) { _ in
                                        // Надо сделать: выбор изображения
                                        // Вызываем метод клоторый создали ниже
                                        self.chooseImagePicker(source: .camera)
            }
            // Устанавливаем значение (.setValue) по определенному ключу
            camera.setValue(cameraIcon, forKey: "image")
            // Выравнимаем текст кнопки слева
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            // Создаем список пользовательских действий photo
            let photo = UIAlertAction(title: "Photo",
                                      style: .default) { _ in
                                        // Надо выбрать картинку
                                        // Вызываем метод клоторый создали ниже
                                        self.chooseImagePicker(source: .photoLibrary)
            }
            // Устанавливаем значение (.setValue) по определенному ключу
            photo.setValue(photoIcon, forKey: "image")
            // Выравнимаем текст кнопки слева
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            // Создаем список пользовательских действий cancel
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            // Теперь необходимо наши Action поместить в UIAlertController
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            // Вызываем UIAlertController
            
            present(actionSheet, animated: true)
            
        } else {
            // Иначе скрыть клавиатуру
            view.endEditing(true)
        }
    }
    
    // MARK: - Сохранение данных
    // Метод который будет сохранять данные из textField
    func saveNewPlayer() {
        
        var image: UIImage?
        //         var imageIsChange = false
        if imageIsChange {
            image = imagePlayer.image
        } else {
            image = #imageLiteral(resourceName: "Даулет")
        }
        
        let imageDate = image?.pngData()
        
        let newPlayer = Player(photo: imageDate,
                               name: namePlayer.text!,
                               teamNumber: 0,
                               payment: payMent.text!,
                               isFavourite: true,
                               rating: 50,
                               position: "ФРВ",
                               numberOfGames: 0,
                               numberOfGoals: 0,
                               winGame: 0,
                               losGame: 0,
                               inTeam: false)
        
        StorageManager.savePlayer(newPlayer)
        
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        // При нажатии на cancel возвращаемся назад
        dismiss(animated: true)
    }
    
}

// MARK: - Text Field Delegate
extension AddPlayerTableViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // private - этот метод будет использоваться исключительно в этом классе
    @objc private func textFieldChanged() {
        // Если поле placeName не пустое
        if namePlayer.text?.isEmpty == false {
            saveButton.isEnabled = true // Кнопка доступна
        } else {
            saveButton.isEnabled = false // Кнопка не доступна
        }
    }
}

// MARK: - Работа с изображениями

// Подпишем наше расширение под протакол UIImagePickerControllerDelegate
extension AddPlayerTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        // Проверяем на доступность выбора изображения
        if UIImagePickerController.isSourceTypeAvailable(source){
            // Если в методе chooseImagePicker параметр source будет доступен то:
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            // Далее работаем с экземпляром класс UIImagePickerController
            imagePicker.allowsEditing = true // Позволит пользователю редактировать изображение
            
            // Выбираем тип источника
            imagePicker.sourceType = source // Мы присваиваем значение параметра source свойству .sourceType
            
            // UIImagePickerController является ViewController и чтобы нам его вызвать, нам надо воспользоваться методом present
            present(imagePicker, animated: true)
        }
    }
    
    // Метод сообщает что выбран статичный фрагмен видео или фото
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Здесь нам надо присвоить outlet-у (imageOfPlace) изображение, которое выбрал пользователь
        // .editedImage - Данный тип контента позволяет использовать отредактированное пользователем изображение
        imagePlayer.image = info[.editedImage] as? UIImage
        
        // Работаем над форматом изображения
        imagePlayer.contentMode = .scaleAspectFill // Позволяет масштабировать изображение по содержимому UIImage
        imagePlayer.clipsToBounds = true // Обрезаем по кроям
        
        // Картинку мы не меняем
        imageIsChange = true
        
        // Выбрав изображение нам необходимо закрыть imagePickerController
        dismiss(animated: true)
    }
}
