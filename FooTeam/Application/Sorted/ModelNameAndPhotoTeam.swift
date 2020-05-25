//
//  ModelTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class ModelNameAndPhotoTeam {
    
    private init() {}
    static let shared = ModelNameAndPhotoTeam()
    
    public func getTeamOne(players: [Player], name: [UILabel], photo: [UIImageView])  {
        var count = 0
        for player in players {
            let image = UIImage(named: player.imageStatic!)
            photo[count].layer.cornerRadius = photo[count].frame.width / 2
            photo[count].image = image
            name[count].text = player.name
            count += 1
        }
    }
}
