//
//  Team.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class Team {
    
    private init() {}
    static let shared = Team()
    
    private var team = Sorted.shared.getData()
    
    var teamOne: [Player] { team[0] }
    var teamTwo: [Player] { team[1] }
    var reserve: [Player] { team[2] }
}
