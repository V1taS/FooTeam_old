//
//  StructurePlayers.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class StructTeamViewController: UIViewController {
    
    var player = Player.getPlayer()
    
    @IBOutlet var photoTeamOne: [UIImageView]!
    @IBOutlet var nameTeamOne: [UILabel]!
    
    @IBOutlet var photoTeamTwo: [UIImageView]!
    @IBOutlet var nameTeamTwo: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPlayer(listPlayer: &player)
        
    }
        
    // ------------ Добавление играков ------------
    func addPlayer(listPlayer players: inout [Player]) {
        players.shuffle()

        var countPlayer = 1
        var indexFirstTeam = 0
        var indexSecondTeam = 0

        for player in players {

            if countPlayer <= 6 {
                if indexFirstTeam <= 5 {
                    nameTeamOne[indexFirstTeam].text = player.name
                    photoTeamOne[indexFirstTeam].image = UIImage(named: player.imageStatic!)
                    photoTeamOne[indexFirstTeam].layer.cornerRadius = photoTeamOne[indexFirstTeam].frame.width / 2
                    indexFirstTeam += 1
                }
            } else if countPlayer <= 12 {
                if indexSecondTeam <= 5 {
                    nameTeamTwo[indexSecondTeam].text = player.name
                    photoTeamTwo[indexSecondTeam].image = UIImage(named: player.imageStatic!)
                    photoTeamTwo[indexSecondTeam].layer.cornerRadius = photoTeamTwo[indexSecondTeam].frame.width / 2
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
