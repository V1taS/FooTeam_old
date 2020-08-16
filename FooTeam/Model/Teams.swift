//
//  Teams.swift
//  iChat
//
//  Created by Виталий Сосин on 10.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Teams: Hashable, Decodable {
    
    var avatarStringURL: String
    var name: String
    var location: String
    var teamType: String
    
    var playersInTeam: [Players]
    var id: String
    var rating: Int = 0
    var captain: Players
    
    init(avatarStringURL: String, name: String, location: String, teamType: String, playersInTeam: [Players], id: String, rating: Int, captain: Players) {
        self.avatarStringURL = avatarStringURL
        self.name = name
        self.location = location
        self.teamType = teamType
        self.playersInTeam = playersInTeam
        self.id = id
        self.rating = rating
        self.captain = captain
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let avatarStringURL = data["avatarStringURL"] as? String,
        let name = data["name"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let playersInTeam = data["playersInTeam"] as? [Players],
            let id = data["id"] as? String,
            let rating = data["rating"] as? Int,
        let captain = data["captain"] as? Players else { return nil }
        
        self.avatarStringURL = avatarStringURL
        self.name = name
        self.location = location
        self.teamType = teamType
        self.playersInTeam = playersInTeam
        self.id = id
        self.rating = rating
        self.captain = captain
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let avatarStringURL = data["avatarStringURL"] as? String,
        let name = data["name"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let playersInTeam = data["playersInTeam"] as? [Players],
            let id = data["id"] as? String,
            let rating = data["rating"] as? Int,
        let captain = data["captain"] as? Players else { return nil }
        
        self.avatarStringURL = avatarStringURL
        self.name = name
        self.location = location
        self.teamType = teamType
        self.playersInTeam = playersInTeam
        self.id = id
        self.rating = rating
        self.captain = captain
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["avatarStringURL": avatarStringURL]
        rep["name"] = name
        rep["location"] = location
        rep["teamType"] = teamType
        rep["playersInTeam"] = playersInTeam
        rep["id"] = id
        rep["rating"] = rating
        rep["captain"] = captain
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Teams, rhs: Teams) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}

