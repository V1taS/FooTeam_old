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
    
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("TTTT")
        
        NameAndPhoto.shared.getTeamOne(players: Team.shared.teamOne,
                                       name: nameTeamOne,
                                       photo: photoTeamOne)
        NameAndPhoto.shared.getTeamOne(players: Team.shared.teamTwo,
                                    name: nameTeamTwo,
                                    photo: photoTeamTwo)
    }
}
