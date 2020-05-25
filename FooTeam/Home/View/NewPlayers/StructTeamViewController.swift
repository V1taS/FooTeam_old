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
        
        ModelAddPlayer.addPlayerNameandImage(nameTeamOne: &self.nameTeamOne,
                                 photoTeamOne: &self.photoTeamOne,
                                 nameTeamTwo: &self.nameTeamTwo,
                                 photoTeamTwo: &self.photoTeamTwo)
    }
}
