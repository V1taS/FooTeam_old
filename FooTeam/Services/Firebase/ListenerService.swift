//
//  ListenerService.swift
//  iChat
//
//  Created by Виталий Сосин on 18.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
    
    static let shared = ListenerService()

    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("players")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func usersObserve(players: [Players], completion: @escaping (Result<[Players], Error>) -> Void) -> ListenerRegistration? {
        var players = players
        let usersListener = usersRef.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { (diff) in
                guard let muser = Players(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !players.contains(muser) else { return }
                    guard muser.id != self.currentUserId else { return }
                    players.append(muser)
                case .modified:
                    guard let index = players.firstIndex(of: muser) else { return }
                    players[index] = muser
                case .removed:
                    guard let index = players.firstIndex(of: muser) else { return }
                    players.remove(at: index)
                }
            }
            completion(.success(players))
        }
        return usersListener
    } // usersObserve
}
