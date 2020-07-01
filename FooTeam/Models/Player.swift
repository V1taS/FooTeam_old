//
//  Player.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import RealmSwift

class Player: Object {
    
    @objc dynamic var photo: Data?
    @objc dynamic var name: String?
    
    @objc dynamic var teamNumber = 0
    @objc dynamic var payment = ""
    @objc dynamic var isFavourite = true
    
    @objc dynamic var rating = 0
    @objc dynamic var position = "ФРВ"
    
    @objc dynamic var numberOfGames = 0
    @objc dynamic var numberOfGoals = 0
    
    @objc dynamic var winGame = 0
    @objc dynamic var losGame = 0
    
    convenience init(photo: Data?,
                     name: String?,
                     teamNumber: Int,
                     payment: String,
                     isFavourite: Bool,
                     rating: Int,
                     position: String,
                     numberOfGames: Int,
                     numberOfGoals: Int,
                     winGame: Int,
                     losGame: Int) {
        self.init()
        
        self.photo = photo
        self.name = name
        self.teamNumber = teamNumber
        self.payment = payment
        self.isFavourite = isFavourite
        self.rating = rating
        self.position = position
        self.numberOfGames = numberOfGames
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
    }
    
    let listPlayers = ["Александр Фадеев", "Павел Богданов", "Артур Илларионов", "Андрей Пахомов", "Александр Добров", "Владимир Мельников", "Егор Малахов", "Андрей Смирнов", "Сосин Виталий", "Александр Руховец", "Илья Гордеев", "Обрадович Милан", "Даулет","Владимир Трифанов" ]
    
    func savePlayer() {
        
        for player in listPlayers {
            
            let image = UIImage(named: player)
            guard let imageData = image?.pngData() else { return }
        
            let newPlayer = Player()
            
            newPlayer.photo = imageData
            newPlayer.name = player
            newPlayer.teamNumber = 0
            newPlayer.payment = "4"
            newPlayer.isFavourite = true
            newPlayer.rating = 50
            newPlayer.position = "ФРВ"
            newPlayer.numberOfGames = 0
            newPlayer.numberOfGoals = 0
            newPlayer.winGame = 0
            newPlayer.losGame = 0
            
            StorageManager.savePlayer(newPlayer)
        }
    }
}
