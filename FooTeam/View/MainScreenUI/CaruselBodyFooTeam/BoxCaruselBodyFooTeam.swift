//
//  BoxCaruselBodyFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxCaruselBodyFooTeam: View {
    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false) {
                
                HStack {
                    CellCaruselBodyFooTeam()
                    CellCaruselBodyFooTeam()
                    CellCaruselBodyFooTeam()
                }
        }
    }
}

struct BoxCaruselBodyFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        BoxCaruselBodyFooTeam()
    }
}
