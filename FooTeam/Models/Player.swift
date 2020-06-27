//
//  Player.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

struct Player: Codable {
    
    var photo: Data
    var name: String
    
    var teamNumber: Int
    var payment: String
    var isFavourite: Bool
    
    var rating: Int
    var position: String
    
    var numberOfGames: Int
    var numberOfGoals: Int
    
    var winGame: Int
    var losGame: Int
}

extension Player {
    static let listTeam = ["Александр Фадеев", "Павел Богданов", "Артур Илларионов", "Андрей Пахомов", "Александр Добров", "Владимир Мельников", "Егор Малахов", "Андрей Смирнов", "Сосин Виталий", "Александр Руховец", "Илья Гордеев", "Обрадович Милан", "Даулет","Владимир Трифанов" ]
    
    static func getPlayer() {
        
        for player in listTeam {
            let newPlayer = Player(photo: (UIImage(named: player)?.pngData())!,
                                  name: player,
                                  teamNumber: 0,
                                  payment: "0",
                                  isFavourite: true,
                                  rating: 50,
                                  position: "ФРВ",
                                  numberOfGames: 0,
                                  numberOfGoals: 0,
                                  winGame: 0,
                                  losGame: 0)
            StorageManager.shared.savePlayer(with: newPlayer)
        }
    }
}
