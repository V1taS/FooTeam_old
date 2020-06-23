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
    
    var teamNumber: Int
    var payment: Int
    var isFavourite: Bool
    
    var rating: Int
    var position: String
    
    var numberOfGames: Int
    var numberOfGoals: Int
    
    var winGame: Int
    var losGame: Int
    
    var dictionary: [String: Any] {
        return ["name": name,
                "teamNumber": teamNumber,
                "payment": payment,
                "isFavourite": isFavourite,
                "rating": rating,
                "position": position,
                "numberOfGames": numberOfGames,
                "numberOfGoals": numberOfGoals,
                "winGame": winGame,
                "losGame": losGame]
    }
}

extension Player {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let teamNumber = dictionary["teamNumber"] as? Int,
            let payment = dictionary["payment"] as? Int,
            let isFavourite = dictionary["isFavourite"] as? Bool,
            let rating = dictionary["rating"] as? Int,
            let position = dictionary["position"] as? String,
            let numberOfGames = dictionary["numberOfGames"] as? Int,
            let numberOfGoals = dictionary["numberOfGoals"] as? Int,
            let winGame = dictionary["winGame"] as? Int,
            let losGame = dictionary["losGame"] as? Int else {return nil}
        
        self.init(name: name, teamNumber: teamNumber, payment: payment, isFavourite: isFavourite, rating: rating, position: position, numberOfGames: numberOfGames, numberOfGoals: numberOfGoals, winGame: winGame, losGame: losGame)
    }
}

extension Player {
    static let listTeam = ["Александр Фадеев", "Павел Богданов", "Артур Илларионов", "Андрей Пахомов", "Александр Добров", "Владимир Мельников", "Егор Малахов", "Андрей Смирнов", "Сосин Виталий", "Александр Руховец", "Илья Гордеев", "Обрадович Милан", "Даулет","Владимир Трифанов" ]
    
    static func getPlayer() -> [Player] {
        var players = [Player]()
        players.shuffle()
        
        for player in listTeam {
            players.append(Player(imageStatic: player, image: UIImage(named: player)!, name: player, teamNumber: 1, payment: 0, isFavourite: true, rating: 50, position: "ЦОП", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0))
        }
        return players
    }
}
