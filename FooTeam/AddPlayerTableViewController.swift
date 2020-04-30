//
//  AddPlayerTableViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class AddPlayerTableViewController: UITableViewController {
    
    var newPlayer: Player?
    var imageIsChange = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var namePlayer: UITextField!
    @IBOutlet weak var payMent: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // В Футоре TableViewController избавляемся от разлиновки (от черточек) путям подставления обычного View где нет контента
        tableView.tableFooterView = UIView()
        
        // Отключаем кнопку SAVE при загрузке
        saveButton.isEnabled = false
        
        // Если поле (placeName) пустое то кнопка SAVE скрыта
        // Каждый раз при редактировании поля (placeName) будет срабатывать этот метод который в свою очередь будет вызывать метод #selector(textFieldChanged) а метод #selector(textFieldChanged) - будет следить за тем что заполнено ли текстовое поле или нет, если заполнено то кнопка SAVE будет доступна.
        namePlayer.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    // MARK: - Table View Delegate
    // Скрываем клавиатуру по нажатию на экран
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
    
    
    // Метод который будет сохранять данные из textField
    func saveNewPlace() {
        
        newPlayer = Player(imageStatic: nil,
                           image: placeImage.image,
                           name: namePlayer.text!,
                           teamNumber: nil,
                           payment: payMent.text!)
        
        
        var image: UIImage?
        // var imageIsChange = false
        if imageIsChange {
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "Даулет")
        }
        
        newPlayer = Player(imageStatic: nil,
                              image: image,
                              name: namePlayer.text!,
                              teamNumber: nil,
                              payment: payMent.text!)
        
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
        placeImage.image = info[.editedImage] as? UIImage
        
        // Работаем над форматом изображения
        placeImage.contentMode = .scaleAspectFill // Позволяет масштабировать изображение по содержимому UIImage
        placeImage.clipsToBounds = true // Обрезаем по кроям
        
        // Картинку мы не меняем
        imageIsChange = true
        
        // Выбрав изображение нам необходимо закрыть imagePickerController
        dismiss(animated: true)
    }
}
