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
    
}
    
    /*
    //MARK: - Количество команд
    func getListOfTeams() {
        
        let igoPlayers = players.filter("isFavourite = true")
        
        var countPlayersInTeam = 5
        let decrementIgoPlayers = igoPlayers.count - 1
        
        if igoPlayers.count % 5 == 0 || decrementIgoPlayers % 5 == 0  {
            countPlayersInTeam = 5
        }
        
        if igoPlayers.count % 6 == 0  || decrementIgoPlayers % 6 == 0  {
            countPlayersInTeam = 6
        }
        
        if igoPlayers.count % 7 == 0 {
            countPlayersInTeam = 7
        }
        
        let countTeams = igoPlayers.count / countPlayersInTeam
        
        switch countTeams {
        case 2:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamOne
                case .teamFree:
                    print("Error Sort players case 2")
                case .teamFour:
                    print("Error Sort players case 2")
                }
            }
        case 3:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamFree
                case .teamFree:
                    try! realm.write {
                        player.teamNumber = 3
                    }
                    currenTeam = .teamOne
                case .teamFour:
                    print("Error Sort players case 3")
                }
            }
        case 4:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamFree
                case .teamFree:
                    try! realm.write {
                        player.teamNumber = 3
                    }
                    currenTeam = .teamFour
                case .teamFour:
                    try! realm.write {
                        player.teamNumber = 4
                    }
                    currenTeam = .teamOne
                }
            }
        default:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamOne
                case .teamFree:
                    print("Error Sort players case 2")
                case .teamFour:
                    print("Error Sort players case 2")
                }
            }
        }
 }/**/*/
