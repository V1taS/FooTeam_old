//
//  StructurePlayers.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class StructTeamViewController: UIViewController {
    
    let player = Player.getPlayer()
    
    @IBOutlet var photoTeamOne: [UIImageView]!
    @IBOutlet var nameTeamOne: [UILabel]!
    
    @IBOutlet var photoTeamTwo: [UIImageView]!
    @IBOutlet var nameTeamTwo: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPlayer(listPlayer: player)
        
//        nameTeamOne[0].text = "Vitalii"

        // Do any additional setup after loading the view.
    }
        
        
    
    // ------------ Добавление играков ------------
    func addPlayer(listPlayer players: [Player]) {

        var countPlayer = 1
        var indexFirstTeam = 0
        var indexSecondTeam = 0

        for player in players {

            if countPlayer <= 6 {
                if indexFirstTeam <= 5 {
                    nameTeamOne[indexFirstTeam].text = player.name
                    photoTeamOne[indexFirstTeam].image = UIImage(named: player.imageStatic!)
                    indexFirstTeam += 1
                }
            } else if countPlayer <= 12 {
                if indexSecondTeam <= 5 {
                    nameTeamTwo[indexSecondTeam].text = player.name
                    photoTeamTwo[indexSecondTeam].image = UIImage(named: player.imageStatic!)
                    indexSecondTeam += 1
                }
            } else if countPlayer >= 13{
                // здесь будут запасные игроки
                print(player.name)
            }
            countPlayer += 1
        }
    }
    // ------------ Добавление играков ------------
}
