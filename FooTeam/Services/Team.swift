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
    
    private init() {}
    
    static let rating = "rating = 90 OR rating = 91 OR rating = 92 OR rating = 93 OR rating = 94 OR rating = 95 OR rating = 96 OR rating = 97 OR rating = 98 OR rating = 99"
    
    //MARK: - Список кто идет
    func getIgo(_ players: [Player]) -> [Player] {
        var igoPlayers: [Player] = []
        
        for player in players {
            if player.isFavourite {
                igoPlayers.append(player)
            }
        }
        return igoPlayers
    }
    
    //MARK: - Количество команд
    func getListOfTeams(_ number: Int) -> [[Player]] {
        
        var teams: [[Player]] = []
        
        for _ in 0...number {
            let team = [Player]()
            teams.append(team)
        }
        return teams
    }
    
    
    //MARK: - Делаем сортировку игроков

    
    //MARK: - Устанавливает имена
    func setTeamOne(players: [Player], name: [UILabel])  {
        var count = 0
        for player in players {
            name[count].text = player.name
            count += 1
        }
    }
    
    //MARK: - Устанавливает имена и фото
    func setTeamOne(players: [Player], name: [UILabel], photo: [UIImageView])  {
        
        var count = 0
        for player in players {
            let image = player.photo
            photo[count].layer.cornerRadius = photo[count].frame.width / 2
            photo[count].image = UIImage(data: image!)
            name[count].text = player.name
            count += 1
        }
    }
}
