//
//  ModelList.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

// В качестве моделей данных используют структуры (НЕ ТРЕБУЮТ СОЗДАНИЯ ИНИЦИАЛИЗАТОРОВ т.к. ИМЕЮТ ВСТРОЕННЫЙ)
// Нам достаточно будет перечислить все необходимые свойства

struct Player {
    var imageStatic: String?
    var image: UIImage?
    var name: String
    var teamNumber: String?
    var payment: String
    var isFavourite: Bool
    
    static let listTeam = ["Александр Фадеев", "Павел Богданов", "Артур Илларионов", "Андрей Пахомов", "Александр Добров", "Владимир Мельников", "Егор Малахов", "Андрей Смирнов", "Сосин Виталий", "Александр Руховец", "Илья Гордеев", "Обрадович Милан", "Даулет","Владимир Трифанов" ]
    
    static func getPlayer() -> [Player] {
        var players = [Player]()
        players.shuffle()
        
        for player in listTeam {
            players.append(Player(imageStatic: player, image: nil, name: player, teamNumber: "Команда: 1 или 2", payment: "Подписка до 05.30 игр ✅", isFavourite: false))
        }
        return players
    }
}
