//
//  ModelOnlyNameTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//
import UIKit

class ModelOnlyNameTeam {
    
    private init() {}
    static let shared = ModelOnlyNameTeam()
    
    public func getTeamOne(players: [Player], name: [UILabel])  {
        var count = 0
        for player in players {
            name[count].text = player.name
            count += 1
        }
    }
}
