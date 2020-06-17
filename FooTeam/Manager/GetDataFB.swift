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
    
    private var players: Player!
    
    var db: Firestore!
    
    func getListPlayersWithFB() {
        db.collection("players").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //                    print("\(document.documentID) => \(document.data())")
                    guard let players = Player.init(dictionary: document.data()) else { return }
                    self.players = players
                }
            }
        }
    }
}
