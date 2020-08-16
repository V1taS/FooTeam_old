//
//  BoxTopPlayersFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxTopPlayersFooTeam: View {
    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false) {
                HStack {
                    CellTopPlayersFooTeam()
                    CellTopPlayersFooTeam()
                    CellTopPlayersFooTeam()
                    CellTopPlayersFooTeam()
                    CellTopPlayersFooTeam()
                    
                }
                
        }
    }
}

struct BoxTopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        BoxTopPlayersFooTeam()
    }
}
