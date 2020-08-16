//
//  BackgroundFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BackgroundFooTeam: View {
    
    let centerColor: Color
    
    var body: some View {
        let colors = Gradient(colors: [.gray, .black, centerColor, .black, .gray])
        let gradient = LinearGradient(gradient: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
        return Rectangle()
        .fill(gradient)
    }
}

struct BackgroundFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundFooTeam(centerColor: .green)
    }
}
