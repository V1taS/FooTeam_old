//
//  TeamsFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct TeamsFooTeam: View {
    var body: some View {
        VStack {
            Text("Основной состав")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                ListPlayersFooTeam(countPlayers: 10)
                ListPlayersFooTeam(countPlayers: 10)
            }
            
            Text("Запасные игроки")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                ListPlayersFooTeam(countPlayers: 4)
                ListPlayersFooTeam(countPlayers: 4)
            }
        } .padding()
    }
}

struct TeamsFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TeamsFooTeam()
    }
}
