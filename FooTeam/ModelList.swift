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
    var image: UIImage?
    var imageStatic: String?
    var name: String
    var position: String?
    
    static let listTeam = ["Александр Фадеев", "Павел Богданов", "Артур Илларионов", "Андрей Пахомов", "Александр Добров", "Владимир Мельников", "Егор Малахов", "Андрей Смирнов", "Сосин Виталий", "Александр Руховец", "Илья Гордеев", "Обрадович Милан", "Даулет","Владимир Трифанов" ]
    
    static func getPlayer() -> [Player] {
        var players = [Player]()
        
        for player in listTeam {
            players.append(Player(image: nil, imageStatic: player, name: player, position: player))
        }
        return players
    }
}
