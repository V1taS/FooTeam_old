//
//  ModelList.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

struct Player {
    var imageStatic: String?
    var image: UIImage?
    var name: String
    
    var teamNumber: Int?
    var payment: String?
    var isFavourite: Bool
    
    var rating: Int
    var position: String?
    
    var numberOfGames = 0
    var numberOfGoals = 0
    
    var winGame = 0
    var losGame = 0
    
    static let listTeam = ["Александр Фадеев", "Павел Богданов", "Артур Илларионов", "Андрей Пахомов", "Александр Добров", "Владимир Мельников", "Егор Малахов", "Андрей Смирнов", "Сосин Виталий", "Александр Руховец", "Илья Гордеев", "Обрадович Милан", "Даулет","Владимир Трифанов" ]
    
    static func getPlayer() -> [Player] {
        var players = [Player]()
        players.shuffle()
        
        for player in listTeam {
            players.append(Player(imageStatic: player, image: nil, name: player, teamNumber: nil, payment: nil, isFavourite: true, rating: 50, position: "ЦОП", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0))
        }
        return players
    }
}
