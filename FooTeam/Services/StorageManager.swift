//
//  StorageManager.swift
//  FooTeam
//
//  Created by Виталий Сосин on 26.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let contactKey = "FoTeam"
    
    func savePlayer(with player: Player) {
        var players = fetchPlayers()
        players.append(player)
        guard let data = try? JSONEncoder().encode(players) else { return }
        userDefaults.set(data, forKey: contactKey)
    }
    
    func fetchPlayers() -> [Player] {
        guard let data = userDefaults.object(forKey: contactKey) as? Data else { return [] }
        guard let players = try? JSONDecoder().decode([Player].self, from: data) else { return [] }
        return players
    }
    
    func deletePlayer(at index: Int) {
        var players = fetchPlayers()
        players.remove(at: index)
        
        guard let data = try? JSONEncoder().encode(players) else { return }
        userDefaults.set(data, forKey: contactKey)
    }
    
    func insertPlayer(player: Player, at index: Int) {
        var players = fetchPlayers()
        
        players.insert(player, at: index)
        
        guard let data = try? JSONEncoder().encode(players) else { return }
        userDefaults.set(data, forKey: contactKey)
    }
    
    func reSavePlayer(player: Player, at index: Int) {
        var players = fetchPlayers()
        players[index] = player
        
        guard let data = try? JSONEncoder().encode(players) else { return }
        userDefaults.set(data, forKey: contactKey)
    }
}
