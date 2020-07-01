//
//  StorageManager.swift
//  FooTeam
//
//  Created by Виталий Сосин on 26.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    //MARK: - метод сохранения
    static func savePlayer(_ player: Player) {
        
        try! realm.write {
            realm.add(player)
        }
    }
    
    //MARK: - метод удаления
    static func deletePlayer(_ player: Player) {
        
        try! realm.write {
            realm.delete(player)
        }
    }
    
    //MARK: - метод перезаписи
    static func rewritePlayer(_ currentPlayer: Player, newPlayer: Player) {
        
        try! realm.write {
            currentPlayer.photo = newPlayer.photo
            currentPlayer.name = newPlayer.name
            currentPlayer.teamNumber = newPlayer.teamNumber
            currentPlayer.payment = newPlayer.payment
            currentPlayer.isFavourite = newPlayer.isFavourite
            currentPlayer.rating = newPlayer.rating
            currentPlayer.position = newPlayer.position
            currentPlayer.numberOfGames = newPlayer.numberOfGames
            currentPlayer.numberOfGoals = newPlayer.numberOfGoals
            currentPlayer.winGame = newPlayer.winGame
            currentPlayer.losGame = newPlayer.losGame
        }
    }
}
