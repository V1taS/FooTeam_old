//
//  Team.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

//MARK: - Team - отсортированные комманды
class Team {
    
    static let shared = Team()
    
    var teamOne: [Player] { team[0] }
    var teamTwo: [Player] { team[1] }
    var teamAll: [Player] { DB.shared.players }
    var teamAllRandom: [Player] { team[0] + team[1] + team[2] }
    var reserve: [Player] { team[2] }
    
    private var team = Sorted.shared.getData()
    
    private init() {}
}

//MARK: - Sorted логика сортировки
class Sorted {
    
    static let shared = Sorted()
    
    private let players = DB.shared.players
    
    func getData() -> [[Player]] {
        
        let randomPlayers = players.shuffled()
        
        var teamOne = [Player]()
        var teamTwo = [Player]()
        var reserve = [Player]()
        
        for player in randomPlayers {
            guard player.isFavourite else { break }
            
            if teamOne.count <= 5 {
                teamOne.append(player)
                continue
            } else if teamTwo.count <= 5 {
                teamTwo.append(player)
                continue
            }
            reserve.append(player)
        }
        return [teamOne, teamTwo, reserve]
    }
    
    private init() {}
}


//MARK: - Устанавливает имена
class OnlyName {
    
    static let shared = OnlyName()
    
    func getTeamOne(players: [Player], name: [UILabel])  {
        var count = 0
        for player in players {
            name[count].text = player.name
            count += 1
        }
    }
    private init() {}
}

//MARK: - Устанавливает имена и фото
class NameAndPhoto {
    
    static let shared = NameAndPhoto()
    
    func getTeamOne(players: [Player], name: [UILabel], photo: [UIImageView])  {
        
        var count = 0
        for player in players {
            let image = player.photo
            photo[count].layer.cornerRadius = photo[count].frame.width / 2
            photo[count].image = UIImage(data: image)
            name[count].text = player.name
            count += 1
        }
    }
    private init() {}
}
