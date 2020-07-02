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
    func getListTeam(numberTeams: Int) -> [[Player]] {
        
        let players = [Player]()
        
        var teamsArray = getListOfTeams(numberTeams)
        let playersIgo = getIgo(players)
        let numberPlayersInTeam = playersIgo.count / teamsArray.count
        var reserv = 0
        var indexTeam = 0
        
        if !numberPlayersInTeam.isMultiple(of: numberTeams) {
            reserv += 1
        }
        
        for player in playersIgo {
            
            if teamsArray[indexTeam].count <= numberPlayersInTeam - 1 {
                teamsArray[indexTeam].append(player)
            } else {
                indexTeam += 1
                teamsArray[indexTeam].append(player)
            }
        }
        return [players]
    }
    
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
