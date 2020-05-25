//
//  Sorted.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

class Sorted {
    private init() {}
    static let shared = Sorted()
    private let players = Player.getPlayer()

    public func getData() -> [[Player]] {
        
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
}
