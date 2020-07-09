//
//  Team.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import RealmSwift

//MARK: - Team - отсортированные комманды
class Team {
    
    static let shared = Team()
    
    private init() {}
    
    static let rating = "rating = 90 OR rating = 91 OR rating = 92 OR rating = 93 OR rating = 94 OR rating = 95 OR rating = 96 OR rating = 97 OR rating = 98 OR rating = 99"
    
    var currenTeam = CurrentTeam.teamOne
    
    // MARK: - Bet on the game
    func bet(_ players: Results<Player>,
             _ betTeamOneLabel: UILabel!,
             _ betTeamTwoLabel: UILabel!,
             _ betTeamMidleLabel: UILabel!) {
        let teamOne = players.filter("isFavourite = true").filter("teamNumber = 1")
        let teamTwo = players.filter("isFavourite = true").filter("teamNumber = 2")
        var teamOneTotal = 0
        var teamTwoTotal = 0
        
        for player in teamOne {
            teamOneTotal += player.rating
        }
        
        for player in teamTwo {
            teamTwoTotal += player.rating
        }
        
        let teamOneBet = Double(teamTwoTotal) / Double(teamOneTotal) + 0.412
        let teamTwoBet = Double(teamOneTotal) / Double(teamTwoTotal) + 0.474
        let teamMidle = (teamOneBet + teamTwoBet) / 1.45
        
        betTeamOneLabel.text = String(format: "%.2f", teamOneBet)
        betTeamTwoLabel.text = String(format: "%.2f", teamTwoBet)
        betTeamMidleLabel.text = String(format: "%.2f", teamMidle)
    }
    
    // MARK: - Segmented Control for teams
    func segmentedControlInsertTeam(_ players: Results<Player>, _ segmentedControl: UISegmentedControl!) {
        
        segmentedControl.removeAllSegments()
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
        
        if igoPlayers.count >= 10 {
            let countTeams = igoPlayers.count / countPlayersInTeam
            
            for index in 0..<countTeams {
                segmentedControl.insertSegment(withTitle: "Команда - \(index + 1)",
                    at: index,
                    animated: false)
            }
        } else {
            let countTeams = igoPlayers.count / countPlayersInTeam
            
            for index in 0...countTeams {
                segmentedControl.insertSegment(withTitle: "Команда - \(index + 1)",
                    at: index,
                    animated: false)
            }
        }
        
    }
    
    //MARK: - Количество команд
    func getListOfTeams(_ players: Results<Player>) {
        
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
    }
    
    
    //MARK: - Общий рейтинг
    func overallRating(_ players: Results<Player>) {
        Team.shared.goalkeaperRating(players)
        Team.shared.protectionRating(players)
        Team.shared.havebekRating(players)
        Team.shared.forfardRating(players)
    }
    //MARK: - рейтинг для вратарей
    func goalkeaperRating(_ players: Results<Player>) {
        for player in players.filter("position = 'ВРТ'") {
            
            var rating = 49
            
            let countGame = player.numberOfGames
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                
                if player.winGame == 1 {
                    rating += 29
                } else {
                    rating += 25
                }
                
            } else {
                
                if player.winGame > player.losGame {
                    rating += 37
                } else {
                    rating += 10
                }
            }
            
            if player.inTeam == true { rating += 7 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
        }
    }
    
    //MARK: - рейтинг для защитников
    func protectionRating(_ players: Results<Player>) {
        for player in players.filter("position = 'ЦЗ'") {
            
            var rating = 50
            
            let countGame = player.numberOfGames
            let countGoals = player.numberOfGoals
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                
                if player.winGame == 1 {
                    rating += 32
                } else {
                    rating += 6
                }
                
                switch countGoals {
                case 0:
                    rating += 0
                case 1:
                    rating += 9
                default:
                    rating += 13
                }
                
            } else {
                
                let midleGoals = ((countGoals / countGame) * 19)
                
                if midleGoals > 40 {
                    rating += 41
                } else if midleGoals <= 10 {
                    rating += 21
                } else {
                    rating += midleGoals
                }
                
                if player.winGame >= player.losGame {
                    rating += 11
                } else {
                    rating += 4
                }
                
            }
            
            if player.inTeam == true { rating += 7 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
        }
    }
    
    //MARK: - рейтинг для полу защитников
    func havebekRating(_ players: Results<Player>) {
        for player in players.filter("position = 'ЦП'") {
            
            var rating = 50
            
            let countGame = player.numberOfGames
            let countGoals = player.numberOfGoals
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                
                if player.winGame == 1 {
                    rating += 12
                } else {
                    rating += 6
                }
                
                switch countGoals {
                case 0:
                    rating += 10
                case 1:
                    rating += 19
                case 2...3:
                    rating += 23
                default:
                    rating += 27
                }
                
            } else {
                
                let midleGoals = ((countGoals / countGame) * 19)
                
                if midleGoals > 40 {
                    rating += 32
                } else if midleGoals <= 10 {
                    rating += 7
                } else {
                    rating += midleGoals
                }
            }
            
            if player.inTeam == true { rating += 4 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
        }
    }
    
    //MARK: - рейтинг для нападающих
    func forfardRating(_ players: Results<Player>) {
        for player in players.filter("position = 'ФРВ'") {
            
            var rating = 50
            
            let countGame = player.numberOfGames
            let countGoals = player.numberOfGoals
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                rating += 10
                switch countGoals {
                case 0...1:
                    rating += 9
                case 2...3:
                    rating += 17
                case 4:
                    rating += 25
                default:
                    rating += 29
                }
            } else {
                
                let midleGoals = ((countGoals / countGame) * 19)
                
                if midleGoals > 40 {
                    rating += 40
                } else if midleGoals <= 10 {
                    rating += 5
                } else {
                    rating += midleGoals
                }
            }
            
            if player.inTeam == true { rating += 4 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
        }
    }
}
