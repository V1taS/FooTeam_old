//
//  ListPlayersFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ListPlayersFooTeam: View {
    
    let countPlayers: Int
    
    var body: some View {
        VStack {
            ForEach(1..<countPlayers) { item in
                HStack {
                    Text("\(item)) ")
                    Text("Илларионов Артур")
                        .background(Color(red: 0, green: 1, blue: 0, opacity: 0.1))
                }
            }
        }
    }
}

struct ListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersFooTeam(countPlayers: 10)
    }
}
