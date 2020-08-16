//
//  FirestoreService.swift
//  iChat
//
//  Created by Виталий Сосин on 17.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("players")
    }
    
    private var waitingChatsRef: CollectionReference {
        return db.collection(["players", currentUser.id, "waitingChats"].joined(separator: "/"))
    }
    
    private var activeChatsRef: CollectionReference {
        return db.collection(["players", currentUser.id, "activeChats"].joined(separator: "/"))
    }
    
    var currentUser: Players!
    
    func getUserData(user: User, completion: @escaping (Result<Players, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = Players(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                self.currentUser = muser
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, name: String?, avatarImage: UIImage?, whoAreYou: String?, positionPlayer: String, completion: @escaping (Result<Players, Error>) -> Void) {
        
        guard Validators.isFilled(username: name, whoAreYou: whoAreYou) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImage != #imageLiteral(resourceName: "Даулет") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var muser = Players(name: name!, email: email, avatarStringURL: "not exist", whoAreYou: whoAreYou!, id: id, teamNumber: 0, payment: "", isFavourite: false, inTeam: false, rating: 50, position: positionPlayer, numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: false)

        StorageService.shared.upload(photo: avatarImage!) { (result) in
            switch result {
                
            case .success(let url):
                muser.avatarStringURL = url.absoluteString
                self.usersRef.document(muser.id).setData(muser.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } // StorageService
    } // saveProfileWith
    
    
    func saveTeamWith(avatarTeam: UIImage?, name: String?, location: String?, teamType: String?, playersInTeam: [Players]?, id: String?, rating: Int?, captain: Players?, completion: @escaping (Result<Teams, Error>) -> Void) {
        
        guard Validators.isFilled(teamName: name, location: location) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarTeam != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var team = Teams(avatarStringURL: "not exist", name: name!, location: location!, teamType: teamType!, playersInTeam: playersInTeam!, id: id!, rating: rating!, captain: captain!)

        StorageService.shared.upload(photo: avatarTeam!) { (result) in
            switch result {
                
            case .success(let url):
                team.avatarStringURL = url.absoluteString
                self.usersRef.document(team.id).setData(team.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(team))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } // StorageService
    } // saveProfileWith
}
