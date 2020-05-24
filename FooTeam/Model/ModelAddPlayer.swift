//
//  ModelAddPlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 24.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

struct ModelAddPlayer {
    
    static var players = Player.getPlayer()
    
    // ------------ Добавление играков имя и фото ------------
    static func addPlayerNameandImage(
        nameTeamOne: inout [UILabel],
        photoTeamOne: inout [UIImageView],
        nameTeamTwo: inout [UILabel],
        photoTeamTwo: inout [UIImageView]
    ) {
        
        
        
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
                    
                    if photoTeamTwo[indexSecondTeam].image != nil {
                        photoTeamTwo[indexSecondTeam].image = UIImage(named: player.imageStatic!)
                        photoTeamTwo[indexSecondTeam].layer.cornerRadius = photoTeamTwo[indexSecondTeam].frame.width / 2
                    }
                    
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
    
    // ------------ Добавление играков только имя ------------
    static func addPlayerName(nameTeamOne: inout [UILabel],
                              nameTeamTwo: inout [UILabel]) {
        
        var countPlayer = 1
        var indexFirstTeam = 0
        var indexSecondTeam = 0
        
        for player in players {
            
            if countPlayer <= 6 {
                if indexFirstTeam <= 5 {
                    nameTeamOne[indexFirstTeam].text = player.name
                    indexFirstTeam += 1
                }
            } else if countPlayer <= 12 {
                if indexSecondTeam <= 5 {
                    nameTeamTwo[indexSecondTeam].text = player.name
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
