//
//  DB.swift
//  FooTeam
//
//  Created by Виталий Сосин on 26.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class DB {
    
    static let shared = DB()
    
    var players = StorageManager.shared.fetchPlayers()
    
    private init() {}
}
