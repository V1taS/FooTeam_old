//
//  HeaderFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct HeaderFooTeam: View {
    
    @Binding var index: Int
    @Binding var show: Bool
    
    var body: some View {
        HStack {
            
            HStack {
                Button(action: {
                    
                    withAnimation{
                        
                        self.show.toggle()
                    }
                    
                }) {
                    
                    
                    Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                        .resizable()
                        .frame(width: self.show ? 18 : 22, height: 20)
                        .foregroundColor(Color.black)
                }
            }
            
            Text(self.index == 0 ? "FooTeam" : (self.index == 1 ? "Чат" : (self.index == 2 ? "Контакты" : "О Нас")))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
            
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .font(.system(size: 20))
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .shadow(color: .gray, radius: 10, x: -2, y: 7)
                .padding(.trailing)
            
            Image(systemName: "questionmark.circle")
                .font(.system(size: 20))
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .shadow(color: .gray, radius: 10, x: -2, y: 7)
//                .padding(.trailing)
        } .padding(.top, 30)
    }
}

struct HeaderFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        HeaderFooTeam(index: .constant(0), show: .constant(false))
    }
}
