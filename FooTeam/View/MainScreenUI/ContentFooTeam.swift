//
//  ContentFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ContentFooTeam: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TopPlayersFooTeam()
            CaruselBodyFooTeam()
        }
    }
}

struct ContentFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ContentFooTeam()
    }
}
