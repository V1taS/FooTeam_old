//
//  StructurePlayers.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//
import UIKit

class StructTeamViewController: UIViewController {
    
    @IBOutlet var photoTeamOne: [UIImageView]!
    @IBOutlet var nameTeamOne: [UILabel]!
    
    @IBOutlet var photoTeamTwo: [UIImageView]!
    @IBOutlet var nameTeamTwo: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelNameAndPhotoTeam.shared.getTeamOne(players: Team.shared.teamOne,
                                    name: nameTeamOne,
                                    photo: photoTeamOne)
        ModelNameAndPhotoTeam.shared.getTeamOne(players: Team.shared.teamTwo,
                                    name: nameTeamTwo,
                                    photo: photoTeamTwo)
    }
}
