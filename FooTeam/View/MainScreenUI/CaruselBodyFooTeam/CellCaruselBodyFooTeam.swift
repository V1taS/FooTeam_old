//
//  CellCaruselBodyFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellCaruselBodyFooTeam: View {

    let backgroundColor: Color = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    
    var body: some View {
        ZStack {
            Color(.blue)
                .frame(width: 360, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            BackgroundFooTeam(centerColor: backgroundColor)
                .frame(width: 360, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            HStack {
                Image("team")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .offset(x: 0, y: 0)
                VStack {
                    Text("Моя команда")
                        .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        .font(.title)
                        .fontWeight(.bold)
                    HStack  {
                        Text("Всего игроков:")
                        .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        Text("18")
                        .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                    }
                    
                    HStack  {
                        Text("Придут на игру:")
                        .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        Text("15")
                        .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                    }
                }
            }
        } .padding(.leading)
    }
}


struct CellCaruselBodyFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        CellCaruselBodyFooTeam()
    }
}
