//
//  ContentFooTeamMenu.swift
//  iChat
//
//  Created by Виталий Сосин on 14.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftUI

struct ContentFooTeamMenu: View {
    
    @State var index = 0
    @State var show = false
    @State var isPresentedAlertSignOut = false
    
    var body: some View {
        
        ZStack{
            
            HStack{
                VStack(alignment: .leading, spacing: 12) {
                    Image("alexAva")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .clipShape(Circle())
                    Text("Привет,")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    Text("Сосин Виталий")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                    Button(action: {
                        self.index = 0
                        
                        withAnimation{
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25){
                            Image("catalogue")
                                .foregroundColor(self.index == 0 ? Color("Color1") : Color.white)
                            
                            Text("Главная")
                                .foregroundColor(self.index == 0 ? Color("Color1") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    .padding(.top,25)
                    
                    Button(action: {
                        self.index = 1
                        
                        withAnimation{
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image("cart")
                                .foregroundColor(self.index == 1 ? Color("Color1") : Color.white)
                            
                            
                            Text("Чат с командой")
                                .foregroundColor(self.index == 1 ? Color("Color1") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 2
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image("fav")
                                .foregroundColor(self.index == 2 ? Color("Color1") : Color.white)
                            
                            
                            Text("Контакты")
                                .foregroundColor(self.index == 2 ? Color("Color1") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 2 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 3
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image("orders")
                                .foregroundColor(self.index == 3 ? Color("Color1") : Color.white)
                            
                            
                            Text("О нас")
                                .foregroundColor(self.index == 3 ? Color("Color1") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color("Color1").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical,30)
                    
                    Button(action: {
                        
                        self.isPresentedAlertSignOut.toggle()
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image("out")
                                .foregroundColor(Color.white)
                            
                            
                            Text("Выход")
                                .foregroundColor(Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,25)
                .padding(.horizontal,20)
                
                Spacer(minLength: 0)
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            
            VStack(spacing: 0){
                
                HStack(spacing: 15){
                    
                    HeaderFooTeam(index: $index, show: $show)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                
                GeometryReader {_ in
                    
                    VStack{
                        
                        if self.index == 0{
                            
                            MassegeFooTeam()
                        }
                        else if self.index == 1{
                            
                            MassegeFooTeam()
                        }
                        else if self.index == 2{
                            
                            MassegeFooTeam()
                        }
                        else{
                            
                            MassegeFooTeam()
                        }
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(self.show ? 30 : 0)
            .scaleEffect(self.show ? 0.6 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
            .rotationEffect(.init(degrees: self.show ? -5 : 0))
            
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
            
        .alert(isPresented: self.$isPresentedAlertSignOut) {
            Alert(title: Text("Внимание"),
                  message: Text("Вы хотите выйти из приложения?"),
                  primaryButton: Alert.Button.default(Text("Отмена")),
                  secondaryButton: Alert.Button.destructive(
                    Text("Выйти"), action: {
                        do {
                            try Auth.auth().signOut()
                            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                            window?.rootViewController = AuthViewController()
                        } catch {
                            print("Error signing out: \(error.localizedDescription)")
                        }
                  }
                )
            )
        }
    }
    
}

struct MassegeFooTeam : View {
    
    var body: some View{
        
        VStack{
            ContentFooTeam()
        }
    }
}

struct ContentFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentFooTeamMenu()
    }
}
