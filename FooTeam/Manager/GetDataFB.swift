//
//  GetDataFB.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//
import Firebase

class GetDataFB {
    
    private init() {}
    static let shared = GetDataFB()
    
    var players: [Player] = []
    
    var db: Firestore!
    
    func getListPlayersWithFB() {
        db.collection("players").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //                    print("\(document.documentID) => \(document.data())")
                    guard let players = Player.init(dictionary: document.data()) else { return }
                    
                    let player = Player(imageStatic: players.imageStatic,
                                        image: players.image,
                                        name: players.name,
                                        teamNumber: players.teamNumber,
                                        payment: players.payment,
                                        isFavourite: players.isFavourite,
                                        rating: players.rating,
                                        position: players.position,
                                        numberOfGames: players.numberOfGames,
                                        numberOfGoals: players.numberOfGoals,
                                        winGame: players.winGame,
                                        losGame: players.losGame)
                    self.players.append(player)
                }
            }
        }
    }
}
