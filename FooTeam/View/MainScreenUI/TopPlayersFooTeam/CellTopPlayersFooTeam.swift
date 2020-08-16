//
//  CellTopPlayersFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellTopPlayersFooTeam: View {
    
    let colorLine: UIColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    let colorText: UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    let backgroundColor: Color = Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
    
    let namePlayer: String = "Сосин Виталий"
    let photoPlayer: String = "Сосин Виталий"
    let ratingPlayer: String = "89"
    let positionPlayer: String = "ФРВ"
    
    let game: String = "4"
    let goal: String = "13"
    let win: String = "3"
    let los: String = "1"
    
    
    
    var body: some View {
        ZStack {
            Color(.blue)
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 45))
            BackgroundFooTeam(centerColor: backgroundColor)
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 45))
//            .shadow(color: backgroundColor, radius: 10, x: 5, y: 0)
            VStack {
                
                
                ZStack {
                    Image(photoPlayer)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .cornerRadius(20)
                    
                    
                } .offset(x: 20, y: -5)
                
                
                Text(namePlayer)
                    .foregroundColor(Color(colorText))
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: 180)
                    .lineLimit(1)
                
                ZStack {
                    Color(colorLine)
                        .frame(width: 180, height: 1)
                } .offset(x: 0, y: -10)
                
                
                
                
                HStack {
                    VStack {
                        HStack {
                            Text(game)
                                .foregroundColor(Color(colorText))
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .frame(width: 25)
                            
                            Text("GAME")
                                .foregroundColor(Color(colorText))
                        }
                        
                        HStack {
                            Text(goal)
                                .foregroundColor(Color(colorText))
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .frame(width: 25)
                            
                            Text("GOAL")
                                .foregroundColor(Color(colorText))
                        }
                    } .offset(x: -10, y: 0)
                    
                    
                    
                    VStack {
                        HStack {
                            Text("WIN")
                                .foregroundColor(Color(colorText))
                            Text(win)
                                .foregroundColor(Color(colorText))
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .frame(width: 25)
                        }
                        
                        HStack {
                            Text("LOS")
                                .foregroundColor(Color(colorText))
                            Text(los)
                                .foregroundColor(Color(colorText))
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .frame(width: 25)
                        }
                    } .offset(x: -5, y: 0)
                }
            }
            ZStack {
                VStack {
                    Text(ratingPlayer)
                        .foregroundColor(Color(colorText))
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    
                    Text(positionPlayer)
                        .foregroundColor(Color(colorText))
                        .font(.system(size: 12))
                    
                    Color(colorLine)
                        .frame(width: 20, height: 1)
                    
                    Image("russia")
                        .resizable()
                        .frame(width: 25, height: 15)
                    
                    Color(colorLine)
                        .frame(width: 20, height: 1)
                    
                    Image("khimki")
                        .resizable()
                        .frame(width: 25, height: 30)
                    
                    
                } .offset(x: -70, y: -60)
            }
            
            ZStack {
                
                Color(colorLine)
                    .frame(width: 1, height: 60)
            } .offset(x: 0, y: 90)
            
            ZStack {
                Color(colorLine)
                    .frame(width: 40, height: 1)
            } .offset(x: 0, y: 130)
        }
        .frame(width: 240, height: 350)
    }
}

struct CellTopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        CellTopPlayersFooTeam()
    }
}
