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
                       rating += 31
                   } else {
                       rating += 26
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
            
            var rating = 49
            
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
                
                if player.winGame > player.losGame {
                    rating += 22
                } else {
                    rating += 7
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
            
            var rating = 49
            
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
                    rating += 16
                case 2...3:
                    rating += 19
                default:
                    rating += 31
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
    
    //MARK: - рейтинг для нападающих
    func forfardRating(_ players: Results<Player>) {
        for player in players.filter("position = 'ФРВ'") {
            
            var rating = 49
            
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
                    rating += 37
                } else if midleGoals <= 10 {
                    rating += 22
                } else {
                    rating += midleGoals
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
}
